import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/Product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _itens = dummyProducts;
  bool _showFavoriteOnly = false;

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  List<Product> get itens => _showFavoriteOnly
      ? _itens.where((product) => product.isFavorite).toList()
      : [..._itens];


  void addProduct(final Product product) {
    _itens.add(product);
    notifyListeners();
  }
}
