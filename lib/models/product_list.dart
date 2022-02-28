import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/Product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _itens = dummyProducts;

  List<Product> get itens => [..._itens];

  List<Product> get favoriteItens =>
      _itens.where((product) => product.isFavorite).toList();

  int get itensCount => _itens.length;

  void addProduct(final Product product) {
    _itens.add(product);
    notifyListeners();
  }

  void saveProduct(final Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void updateProduct(final Product product) {
    int index = _itens.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _itens[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(final Product product) {
    int index = _itens.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _itens.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}
