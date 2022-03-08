// ignore_for_file: file_names
import 'dart:convert' show jsonEncode;
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import '../utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool _isFavorite = false;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    bool isFavorite = false,
  }) {
    _isFavorite = isFavorite;
  }

  void _toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(final String token, final String userId) async {
    try {
      _toggleFavorite();
      final response = await http.put(
        Uri.parse('${Constants.userFavoriteUrl}/$userId/$id.json?auth=$token'),
        body: jsonEncode(isFavorite),
      );
      if (response.statusCode >= 400) {
        _toggleFavorite();
        throw HttpException(
          msg: 'Sem conexão com a Internet.',
          statusCode: response.statusCode,
        );
      }
    } catch (error) {
      _toggleFavorite();
      throw HttpException(
        msg: 'Sem conexão com a Internet.',
      );
    }
  }

  bool get isFavorite => _isFavorite;
}
