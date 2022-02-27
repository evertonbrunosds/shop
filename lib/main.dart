import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/product_detail_screen.dart';
import 'package:shop/screens/products_screen.dart';
import 'package:shop/screens/products_overview_screen.dart';
import 'package:shop/utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.brown).copyWith(
            secondary: Colors.lightGreen.shade300,
            error: Colors.deepOrange.shade300,
            primaryContainer: const Color.fromRGBO(215, 206, 201, 1),
          ),
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailScreen(),
          AppRoutes.CART: (context) => const CartScreen(),
          AppRoutes.HOME: (context) => const ProductsOverviewScreen(),
          AppRoutes.ORDERS: (context) => const OrdersScreen(),
          AppRoutes.PRODUCTS: (context) => const ProductsScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
