import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/Product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _itens = dummyProducts;
  final _baseUrl = 'https://shop-cod3r-8dd33-default-rtdb.firebaseio.com';

  List<Product> get itens => [..._itens];

  List<Product> get favoriteItens =>
      _itens.where((product) => product.isFavorite).toList();

  int get itensCount => _itens.length;

  Future<void> saveProduct(final Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(final Product product) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/products.json'),
      body: jsonEncode(
        {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        },
      ),
    );
    final id = jsonDecode(response.body)['name'];
    _itens.add(
      Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduct(final Product product) {
    int index = _itens.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _itens[index] = product;
      notifyListeners();
    }
    return Future.value();
  }

  void removeProduct(final Product product) {
    int index = _itens.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _itens.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}
