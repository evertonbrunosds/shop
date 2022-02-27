import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/models/order_list.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final orders = Provider.of<OrderList>(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Meus Pedidos'),
        iconTheme: IconThemeData(color: colorScheme.secondary),
      ),
      drawer: const AppDrawer(),
      body: Container(
        color: colorScheme.primaryContainer,
        child: ListView.builder(
          itemCount: orders.itensCount,
          itemBuilder: (ctx, index) => OrderWidget(order: orders.itens[index]),
        ),
      ),
    );
  }
}
