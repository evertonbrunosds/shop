import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';

class OrderWidget extends StatelessWidget {
  final Order order;
  const OrderWidget({Key? key, required final this.order}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final day = DateFormat('dd/MM/yyyy').format(order.date);
    final hour = DateFormat('hh:mm').format(order.date);
    return Card(
      child: ListTile(
        title: Text('R\$ ${order.total.toStringAsFixed(2)}'),
        subtitle: Text(
          'Em $day às $hour'
        ),
        trailing: IconButton(
          icon: const Icon(Icons.expand_more),
          onPressed: (){},
        ),
      ),
    );
  }
}
