import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/Product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _itens = [];
  final _baseUrl =
      'https://shop-cod3r-8dd33-default-rtdb.firebaseio.com/products';

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

  Future<void> loadProducts() async {
    _itens.clear();
    final response = await http.get(Uri.parse('$_baseUrl.json'));
    if (response.body != 'null') {
      Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((productId, productData) {
        _itens.add(
          Product(
            id: productId,
            name: productData['name'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite'],
          ),
        );
      });
      notifyListeners();
    }
  }

  Future<void> addProduct(final Product product) async {
    final response = await http.post(
      Uri.parse('$_baseUrl.json'),
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

  Future<void> updateProduct(final Product product) async {
    int index = _itens.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse('$_baseUrl/${product.id}.json'),
        body: jsonEncode(
          {
            'name': product.name,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          },
        ),
      );
      _itens[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(final Product product) async {
    int index = _itens.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      final product = _itens[index];
      _itens.remove(product);
      notifyListeners();
      final response = await http.delete(
        Uri.parse('$_baseUrl/${product.id}.json'),
      );
      if (response.statusCode >= 400) {
        _itens.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possível excluir o produto!',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
