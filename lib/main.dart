import 'package:flutter/material.dart';
import 'package:jd_learn/provider/cart.dart';
import 'package:provider/provider.dart';

import 'package:jd_learn/pages/index_page.dart';
import 'package:jd_learn/provider/navigation_bar.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: BottomNavProvider(),
      ),
      ChangeNotifierProvider<CartProvider>(create: (context) {
        CartProvider provider = new CartProvider();
        return provider;
      })
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }
}
