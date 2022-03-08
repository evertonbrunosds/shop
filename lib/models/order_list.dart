import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import '../utils/constants.dart';

class OrderList with ChangeNotifier {
  final List<Order> _itens = [];
  String _token = '';

  OrderList({required String token, required List<Order> itens}) {
    _token = token;
    _itens.clear();
    _itens.addAll(itens);
  }

  List<Order> get itens => [..._itens];

  int get itensCount => _itens.length;

  Future<void> loadOrders() async {
    List<Order> itens = [];
    final response = await http
        .get(Uri.parse('${Constants.orderBaseUrl}.json?auth=$_token'));
    if (response.body != 'null') {
      Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((orderId, orderData) {
        itens.add(
          Order(
            id: orderId,
            date: DateTime.parse(orderData['date']),
            total: orderData['total'],
            products: (orderData['products'] as List<dynamic>)
                .map((e) => CartItem(
                      id: e['id'],
                      productId: e['productId'],
                      name: e['name'],
                      quantity: e['quantity'],
                      price: e['price'],
                    ))
                .toList(),
          ),
        );
      });
      _itens.clear();
      _itens.addAll(itens.reversed);
      notifyListeners();
    }
  }

  Future<void> addOrder({required final Cart cart}) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.orderBaseUrl}.json?auth=$_token'),
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
            )
            .toList(),
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
