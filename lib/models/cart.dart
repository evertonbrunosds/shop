import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';

import 'Product.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _itens = {};

  void addItem(final Product product) {
    _itens.containsKey(product.id)
        ? _itens.update(
            product.id,
            (existingItem) => CartItem(
                  id: existingItem.id,
                  productId: existingItem.productId,
                  name: existingItem.name,
                  quantity: existingItem.quantity + 1,
                  price: existingItem.price,
                ))
        : _itens.putIfAbsent(
            product.id,
            () => CartItem(
                id: Random().nextDouble().toString(),
                productId: product.id,
                name: product.name,
                quantity: 1,
                price: product.price),
          );
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    for (final cartItem in _itens.values) {
      total += cartItem.price * cartItem.quantity;
    }
    return total;
  }

  void removeItem(final String productId) {
    _itens.remove(productId);
    notifyListeners();
  }

  void clearItens() {
    _itens.clear();
    notifyListeners();
  }

  Map<String, CartItem> get itens => {..._itens};

  int get itensCount => _itens.length;

  bool get isNotEmpty => _itens.isNotEmpty;
}
