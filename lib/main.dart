import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(token: '', itens: []),
          update: (ctx, auth, previewsProductList) => ProductList(
            token: auth.token ?? '',
            itens: previewsProductList?.itens ?? [],
          ),
        ),
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
        routes: AppRoutes.get,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
