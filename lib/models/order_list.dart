import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order.dart';

class OrderList with ChangeNotifier {
  List<Order> _itens = [];

  List<Order> get itens => [..._itens];

  int get itensCount => _itens.length;

  void addOrder({required final Cart cart}) {
    _itens.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        products: cart.itens.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

}
