// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/utils/app_routes.dart';
import '../models/Product.dart';
import '../models/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final Product product = Provider.of<Product>(
      context,
      //POSSIBILITA ATUALIZAR TRECHOS ESPECÍFICOS
      // DA INTERFACE AO INVÉS DE TODA ELA
      listen: false,
    );
    final Cart cart = Provider.of<Cart>(
      context,
      //POSSIBILITA ATUALIZAR TRECHOS ESPECÍFICOS
      // DA INTERFACE AO INVÉS DE TODA ELA
      listen: false,
    );
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          AppRoutes.PRODUCT_DETAIL,
          arguments: product,
        ),
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            title: Text(
              product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, elementProduct, elementBody) => IconButton(
                //O parâmetro _ pode ser substituído como
                //body, preenchendo assim o componente com
                //algo que sirva para preenche-lo
                onPressed: elementProduct.toggleFavorite,
                icon: Icon(elementProduct.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: elementProduct.isFavorite
                    ? colorScheme.error
                    : colorScheme.secondary,
              ),
            ),
            trailing: IconButton(
              onPressed: () => cart.addItem(product),
              icon: const Icon(Icons.shopping_cart),
              color: colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
