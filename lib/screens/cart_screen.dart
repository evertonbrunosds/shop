import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item_widget.dart';
import 'package:shop/models/order_list.dart';

import '../models/cart.dart';
import '../utils/app_routes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final itens = cart.itens.values.toList();
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho de Compras'),
        centerTitle: true,
      ),
      body: Container(
        color: colorScheme.primaryContainer,
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
                    backgroundColor: colorScheme.primary,
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
                  CartButton(colorScheme: colorScheme, cart: cart),
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

class CartButton extends StatefulWidget {
  const CartButton({
    Key? key,
    required this.colorScheme,
    required this.cart,
  }) : super(key: key);

  final ColorScheme colorScheme;
  final Cart cart;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : TextButton(
            child: const Text('COMPRAR'),
            style: TextButton.styleFrom(
              textStyle: TextStyle(color: widget.colorScheme.primary),
            ),
            onPressed: widget.cart.isNotEmpty
                ? () async {
                    setState(() => isLoading = true);
                    await Provider.of<OrderList>(
                      context,
                      listen: false,
                    ).addOrder(cart: widget.cart);
                    widget.cart.clearItens();
                    setState(() => isLoading = false);
                  }
                : null,
          );
  }
}
