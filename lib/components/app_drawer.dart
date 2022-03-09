import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/auth.dart';

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
          onTap: () => Navigator.of(context)
              .pushReplacementNamed(AppRoutes.AUTH_OR_HOME),
        ),
        const Divider(),
        ListTile(
          leading: Icon(
            Icons.payment,
            color: colorScheme.primary,
          ),
          title: const Text('Meus Pedidos'),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS),
        ),
        const Divider(),
        ListTile(
          leading: Icon(
            Icons.edit,
            color: colorScheme.primary,
          ),
          title: const Text('Gerenciar Produtos'),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS),
        ),
        const Divider(),
        ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: colorScheme.primary,
            ),
            title: const Text('Sair'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).signOut();
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
            }),
      ]),
    );
  }
}
