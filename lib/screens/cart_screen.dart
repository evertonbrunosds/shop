import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item_widget.dart';

import '../models/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final itens = cart.itens.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho de Compras'),
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Column(children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              ?.color),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    child: const Text('COMPRAR'),
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) =>
                CartItemWidget(cartItem: itens[index]),
            itemCount: itens.length,
          )),
        ]),
      ),
    );
  }
}
