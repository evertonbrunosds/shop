import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final products = Provider.of<ProductList>(context);
    final colorScheme = Theme.of(context).colorScheme;

    Future<void> _refreshProducts(final BuildContext context) =>
        Provider.of<ProductList>(
          context,
          listen: false,
        ).loadProducts();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme.secondary),
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: products.itensCount,
              itemBuilder: (ctx, index) => Column(
                children: [
                  ProductItem(product: products.itens[index]),
                  const Divider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
