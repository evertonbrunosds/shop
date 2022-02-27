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
}
