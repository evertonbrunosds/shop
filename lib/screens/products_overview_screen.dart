import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/product_grid.dart';
import '../models/product_list.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final provider = Provider.of<ProductList>(context);
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
              onSelected: (final FilterOptions selectedValue) =>
                  selectedValue == FilterOptions.favorite
                      ? provider.showFavoriteOnly()
                      : provider.showAll())
        ],
      ),
      body: const ProductGrid(),
    );
  }
}
