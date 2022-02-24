// ignore_for_file: file_names
import 'package:flutter/material.dart' show ChangeNotifier;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool _isFavorite = false;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    bool isFavorite = false,
  }) {
    _isFavorite = isFavorite;
  }

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  bool get isFavorite => _isFavorite;
}
