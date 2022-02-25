import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes de Produto'),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
