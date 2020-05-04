import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String title;
  ProductDetails({Key key, this.title}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("${widget.title}"),
          ),
          body: Container()),
    );
  }
}
