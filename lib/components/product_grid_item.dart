// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/utils/app_routes.dart';
import '../models/product.dart';
import '../models/cart.dart';

class ProductGridItem extends StatelessWidget {
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
    final auth = Provider.of<Auth>(context, listen: false);
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
                onPressed: () {
                  elementProduct
                      .toggleFavorite(auth.token ?? '', auth.userId ?? '')
                      .catchError((error) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.toString()),
                        duration: const Duration(seconds: 5),
                        backgroundColor: colorScheme.primary,
                      ),
                    );
                  });
                },
                icon: Icon(elementProduct.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: elementProduct.isFavorite
                    ? colorScheme.error
                    : colorScheme.secondary,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              color: colorScheme.secondary,
              onPressed: () {
                cart.addItem(product);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('${product.name} adicionado a lista de desejos.'),
                    duration: const Duration(seconds: 2),
                    backgroundColor: colorScheme.primary,
                    action: SnackBarAction(
                      label: 'DESFAZER',
                      onPressed: () => cart.removeSingleItem(product.id),
                      textColor: colorScheme.error,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
