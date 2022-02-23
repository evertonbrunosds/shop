import 'package:flutter/material.dart';
import 'package:shop/providers/Counter.dart';
import 'package:shop/screens/counter_screen.dart';
import 'package:shop/screens/product_detail_screen.dart';
import 'package:shop/screens/products_overview_screen.dart';
import 'package:shop/util/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)
            .copyWith(secondary: Colors.deepOrangeAccent),
        fontFamily: 'Lato',
      ),
      home: ProductsOverviewScreen(),
      routes: {AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailScreen()},
      debugShowCheckedModeBanner: false,
    );
  }
}
