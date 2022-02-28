// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/product_from_screen.dart';
import '../screens/products_overview_screen.dart';
import '../screens/products_screen.dart';

class AppRoutes {
  static const PRODUCT_DETAIL = '/product-detail';
  static const CART = '/cart';
  static const HOME = '/';
  static const ORDERS = '/orders';
  static const PRODUCTS = '/products';
  static const PRODUCT_FORM = '/product-form';

  static Map<String, WidgetBuilder> get get => {
        PRODUCT_DETAIL: (context) => const ProductDetailScreen(),
        CART: (context) => const CartScreen(),
        HOME: (context) => const ProductsOverviewScreen(),
        ORDERS: (context) => const OrdersScreen(),
        PRODUCTS: (context) => const ProductsScreen(),
        PRODUCT_FORM: (context) => const ProductFromScreen(),
      };
}
