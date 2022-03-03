// ignore_for_file: constant_identifier_names

import '../screens/cart_screen.dart';
import 'package:flutter/material.dart';
import '../screens/orders_screen.dart';
import '../screens/products_screen.dart';
import '../screens/product_from_screen.dart';
import '../screens/product_detail_screen.dart';
import 'package:shop/screens/auth_or_home_screen.dart';

class AppRoutes {
  static const AUTH_OR_HOME = '/';
  static const CART = '/cart';
  static const ORDERS = '/orders';
  static const PRODUCTS = '/products';
  static const PRODUCT_FORM = '/product-form';
  static const PRODUCT_DETAIL = '/product-detail';

  static Map<String, WidgetBuilder> get get => {
        CART: (context) => const CartScreen(),
        ORDERS: (context) => const OrdersScreen(),
        PRODUCTS: (context) => const ProductsScreen(),
        PRODUCT_FORM: (context) => const ProductFromScreen(),
        AUTH_OR_HOME: (context) =>  const AuthOrHomeScreen(),
        PRODUCT_DETAIL: (context) => const ProductDetailScreen(),
      };
}
