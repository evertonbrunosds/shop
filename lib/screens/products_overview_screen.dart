import 'package:flutter/material.dart';
import '../components/product_grid.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoriteOnly = false;
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
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
                  _showFavoriteOnly = FilterOptions.favorite == selectedValue))
        ],
      ),
      body: ProductGrid(showFavoriteOnly: _showFavoriteOnly),
    );
  }
}
