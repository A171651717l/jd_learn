import 'package:flutter/material.dart';
import 'package:jd_learn/provider/cart.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (_, provider, __) {
      return Scaffold(
        appBar: AppBar(title: Text('购物车')),
        body: Container(),
      );
    });
  }
}
