import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget({Key? key, required final this.order}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  @override
  Widget build(final BuildContext context) {
    final day = DateFormat('dd/MM/yyyy').format(widget.order.date);
    final hour = DateFormat('hh:mm').format(widget.order.date);
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
            subtitle: Text(
              'Em $day às $hour',
              style: TextStyle(color: colorScheme.primary),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () => setState(() => _expanded = !_expanded),
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: (widget.order.products.length * 25.0) + 10,
              child: ListView(
                children: widget.order.products
                    .map((product) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                            Text(
                              '${product.quantity}x R\$ ${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 18, color: colorScheme.error),
                            )
                          ],
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
