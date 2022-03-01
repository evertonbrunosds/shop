import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/models/order_list.dart';
import '../components/order_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  Future<void> _refreshOrders(final BuildContext context) =>
      Provider.of<OrderList>(
        context,
        listen: false,
      ).loadOrders();

  @override
  Widget build(final BuildContext context) {
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
        child: FutureBuilder(
          future: _refreshOrders(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return const Center(child: Text('Houver um erro!'));
            } else {
              return Consumer<OrderList>(
                builder: (context, orders, child) => ListView.builder(
                  itemCount: orders.itensCount,
                  itemBuilder: (ctx, index) =>
                      OrderWidget(order: orders.itens[index]),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
