import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Drawer(
      backgroundColor: colorScheme.primaryContainer,
      child: Column(children: [
        AppBar(
          title: const Text('Bem vindo - Everton Bruno'),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
          leading: Icon(
            Icons.shop,
            color: colorScheme.primary,
          ),
          title: const Text('Loja'),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
        ),
        const Divider(),
        ListTile(
          leading: Icon(
            Icons.payment,
            color: colorScheme.primary,
          ),
          title: const Text('Pedidos'),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS),
        ),
      ]),
    );
  }
}
