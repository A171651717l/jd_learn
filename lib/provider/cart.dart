import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jd_learn/model/product_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  Future<void> addToCart(PartData data) async {
    print(data.toJson());
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 存入缓存
    List<String> list = [];
    list.add(json.encode(data.toJson()));
    prefs.setStringList("cartInfo", list);
    // 取出缓存
    // list = prefs.getString("cartInfo");
  }
}
