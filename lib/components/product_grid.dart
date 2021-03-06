import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid_item.dart';
import '../models/product.dart';
import '../models/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  const ProductGrid({
    Key? key,
    required final this.showFavoriteOnly,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final ProductList provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts =
        showFavoriteOnly ? provider.favoriteItens : provider.itens;
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (final context, final index) =>
            ChangeNotifierProvider.value(
          child: ProductGridItem(),
          value: loadedProducts[index],
        ),
      ),
    );
  }
}
