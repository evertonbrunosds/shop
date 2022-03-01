import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order.dart';
import '../utils/constants.dart';

class OrderList with ChangeNotifier {
  final List<Order> _itens = [];

  List<Order> get itens => [..._itens];

  int get itensCount => _itens.length;

  Future<void> addOrder({required final Cart cart}) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.ORDER_BASE_URL}.json'),
      body: jsonEncode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products': cart.itens.values
            .map(
              (cartItem) => {
                'id': cartItem.id,
                'productId': cartItem.productId,
                'name': cartItem.name,
                'quantity': cartItem.quantity,
                'price': cartItem.price,
              },
            ).toList(),
      }),
    );
    final id = jsonDecode(response.body)['name'];
    _itens.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        date: date,
        products: cart.itens.values.toList(),
      ),
    );
    notifyListeners();
  }
}
