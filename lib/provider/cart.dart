import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:jd_learn/model/product_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<PartData> models = [];
  bool isSelectAll = false;

  Future<void> addToCart(PartData data) async {
    // SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 存入缓存
    // List<String> list = [];
    // list.add(json.encode(data.toJson()));
    // prefs.setStringList("cartInfo", list);

    // 取出缓存
    // List<String> list = [];
    // list = prefs.getStringList("cartInfo");

    // 先取出缓存中的数据
    List<String> list = [];
    list = prefs.getStringList("cartInfo");
    Map<String, bool> modelSelectMap = {};
    for (PartData model in models) {
      modelSelectMap.addAll({model.id: model.isSelected});
    }
    models.clear();

    if (list == null) {
      list = [];
      list.add(json.encode(data.toJson()));
      prefs.setStringList("cartInfo", list);
      models.add(data);
      notifyListeners();
    } else {
      List<String> tmpList = [];
      bool isUpdated = false;
      for (var i = 0; i < list.length; i++) {
        PartData tmpData = PartData.fromJson(json.decode(list[i]));
        // 判断缓存中是否有对应的商品
        if (tmpData.id == data.id) {
          tmpData.count = data.count;
          isUpdated = true;
        }

        modelSelectMap.forEach((key, value) {
          if (tmpData.id == key) {
            tmpData.isSelected = value;
          }
        });

        String tmpDataStr = json.encode(tmpData.toJson());
        tmpList.add(tmpDataStr);
        models.add(tmpData);
      }

      // 如果缓存中没有对应商品
      if (isUpdated == false) {
        String str = json.encode(data.toJson());
        tmpList.add(str);
        models.add(data);
      }

      // 存入缓存
      prefs.setStringList("cartInfo", tmpList);
      notifyListeners();
    }
  }

  int getAllCount() {
    int count = 0;
    for (PartData data in this.models) {
      count += data.count;
    }
    return count;
  }

  // 获取购物车商品
  void getCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 取出缓存
    List<String> list = [];
    list = prefs.getStringList("cartInfo");
    if (list != null) {
      for (var i = 0; i < list.length; i++) {
        PartData tmpData = PartData.fromJson(json.decode(list[i]));
        models.add(tmpData);
      }
      notifyListeners();
    }
  }

  // 删除商品
  void removeFromCart(String id) async {
    // 缓存中删除
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = [];
    list = prefs.getStringList("cartInfo");
    for (var i = 0; i < list.length; i++) {
      PartData tmpData = PartData.fromJson(json.decode(list[i]));
      if (tmpData.id == id) {
        list.remove(list[i]);
        break;
      }
    }
    prefs.setStringList("cartInfo", list);

    // 本地数据删除
    for (var i = 0; i < models.length; i++) {
      if (this.models[i].id == id) {
        this.models.remove(this.models[i]);
        break;
      }
    }

    notifyListeners();
  }

  // 选中状态
  void handleSelectById(String id) {
    int tmpCount = 0;
    for (var i = 0; i < this.models.length; i++) {
      if (this.models[i].id == id) {
        this.models[i].isSelected = !this.models[i].isSelected;
      }
      if (this.models[i].isSelected) {
        tmpCount++;
      }
    }
    if (tmpCount == this.models.length) {
      this.isSelectAll = true;
    } else {
      this.isSelectAll = false;
    }

    notifyListeners();
  }

  // 全选
  void handleSelectAll() {
    isSelectAll = !isSelectAll;
    for (var i = 0; i < this.models.length; i++) {
      this.models[i].isSelected = isSelectAll;
    }

    notifyListeners();
  }

  // 统计合计金额
  String getAmount() {
    String amountStr = "0.00";

    for (var i = 0; i < this.models.length; i++) {
      if (this.models[i].isSelected) {
        num price = this.models[i].count *
            NumUtil.getNumByValueStr(this.models[i].price, fractionDigits: 2);
        num amount = NumUtil.getNumByValueStr(amountStr, fractionDigits: 2);
        amountStr = NumUtil.add(amount, price).toString();
      }
    }
    return amountStr;
  }

  // 统计选中商品个数
  int getSelectedCount() {
    int selectedCount = 0;

    for (var i = 0; i < this.models.length; i++) {
      if (this.models[i].isSelected) {
        selectedCount += this.models[i].count;
      }
    }

    return selectedCount;
  }
}
