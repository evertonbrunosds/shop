import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/models/order_list.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders().then((_) {
      setState(() => isLoading = false);
    });
  }

  Future<void> _refreshOrders(final BuildContext context) =>
      Provider.of<OrderList>(
        context,
        listen: false,
      ).loadOrders();

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
        child: RefreshIndicator(
          onRefresh: () => _refreshOrders(context),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: orders.itensCount,
                  itemBuilder: (ctx, index) =>
                      OrderWidget(order: orders.itens[index]),
                ),
        ),
      ),
    );
  }
}
