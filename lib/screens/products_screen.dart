import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/models/product_list.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final products = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
      ),
      drawer: const AppDrawer(),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itensCount,
            itemBuilder: (ctx, index) => Text(products.itens[index].name),
          ),
        ),
      ),
    );
  }
}
