import 'package:flutter/cupertino.dart';
import 'package:jd_learn/config/api.dart';
import 'package:jd_learn/http/request.dart';
import 'package:jd_learn/model/product_info.dart';

class ProductListProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  List<ProductInfoModel> list = List();

  loadProductListData() {
    isLoading = true;
    isError = false;
    errorMsg = "";

    NetRequest().requestData(JdApi.PRODUCTIONS_LIST).then((res) {
      isLoading = false;
      if (res.code == 200 && res.data is List) {
        for (var item in res.data) {
          ProductInfoModel tempModel = ProductInfoModel.fromJson(item);
          list.add(tempModel);
        }
      }
      notifyListeners();
    }).catchError((error) {
      print('error >>>>> $error');
      isError = true;
      errorMsg = error;
      isLoading = false;
      notifyListeners();
    });
  }
}
