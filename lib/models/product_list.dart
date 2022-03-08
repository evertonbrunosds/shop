import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import '../utils/constants.dart';

class ProductList with ChangeNotifier {
  final List<Product> _itens = [];
  String _token = '';
  String _userId = '';

  List<Product> get itens => [..._itens];

  ProductList({
    required String token,
    required String userId,
    required List<Product> itens,
  }) {
    _token = token;
    _itens.clear();
    _itens.addAll(itens);
    _userId = userId;
  }

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
    final response = await http
        .get(Uri.parse('${Constants.productBaseUrl}.json?auth=$_token'));
    if (response.body != 'null') {
      final favResponse = await http.get(
        Uri.parse(
          '${Constants.userFavoriteUrl}/$_userId.json?auth=$_token',
        ),
      );
      Map<String, dynamic> favData =
          favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);
      Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((productId, productData) {
        final bool isFavorite = favData[productId] ?? false;
        _itens.add(
          Product(
            id: productId,
            name: productData['name'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: isFavorite,
          ),
        );
      });
      notifyListeners();
    }
  }

  Future<void> addProduct(final Product product) async {
    final response = await http.post(
      Uri.parse('${Constants.productBaseUrl}.json?auth=$_token'),
      body: jsonEncode(
        {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
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
        Uri.parse(
            '${Constants.productBaseUrl}/${product.id}.json?auth=$_token'),
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
        Uri.parse(
            '${Constants.productBaseUrl}/${product.id}.json?auth=$_token'),
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
