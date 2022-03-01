import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/badge.dart';
import 'package:shop/utils/app_routes.dart';
import '../components/product_grid.dart';
import '../models/cart.dart';
import '../models/product_list.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  ColorScheme _colorScheme(final BuildContext context) =>
      Theme.of(context).colorScheme;

  Future<void> _refreshProducts(final BuildContext context) =>
      Provider.of<ProductList>(
        context,
        listen: false,
      ).loadProducts().catchError((error) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Sem conexão com a Internet.'),
            duration: const Duration(seconds: 5),
            backgroundColor: _colorScheme(context).primary,
          ),
        );
      }).then((value) {
        setState(() {
          _isLoading = false;
        });
      });

  @override
  void initState() {
    super.initState();
    _refreshProducts(context);
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: _colorScheme(context).secondary),
        title: const Text('Shopping Café'),
        centerTitle: true,
        actions: [
          Consumer<Cart>(
              child: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.CART),
                icon: const Icon(Icons.shopping_cart),
              ),
              builder: (ctx, cartElement, child) => Badge(
                    value: cartElement.itensCount,
                    child: child!,
                  )),
          PopupMenuButton(
            color: _colorScheme(context).primaryContainer,
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.favorite,
              ),
              const PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.all,
              ),
            ],
            onSelected: (final FilterOptions selectedValue) => setState(() =>
                _showFavoriteOnly = FilterOptions.favorite == selectedValue),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: _isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Processando... Aguarde!',
                      style: TextStyle(
                        fontSize: 20,
                        color: _colorScheme(context).primary,
                      ),
                    ),
                    const Divider(),
                    const CircularProgressIndicator(),
                  ],
                ),
              )
            : ProductGrid(showFavoriteOnly: _showFavoriteOnly),
      ),
      drawer: const AppDrawer(),
    );
  }
}
