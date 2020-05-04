import 'package:flutter/cupertino.dart';
import 'package:jd_learn/config/api.dart';
import 'package:jd_learn/http/request.dart';
import 'package:jd_learn/model/product_detail_model.dart';

class ProductdetailProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  ProductDetailModel model;

  loadProductData({String id}) {
    isLoading = true;
    isError = false;
    errorMsg = "";

    NetRequest().requestData(JdApi.PRODUCTIONS_DETAIL).then((res) {
      isLoading = false;
      if (res.code == 200) {
        for (var item in res.data) {
          ProductDetailModel tempModel = ProductDetailModel.fromJson(item);
          if (tempModel.partData.id == id) {
            model = tempModel;
          }
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

  void changeBaitiaoSelected(int index) {
    if (this.model.baitiao[index].select == false) {
      for (var i = 0; i < this.model.baitiao.length; i++) {
        if (i == index) {
          this.model.baitiao[i].select = true;
        } else {
          this.model.baitiao[i].select = false;
        }
      }

      notifyListeners();
    }
  }

  void changeProductCount(int count) {
    if (count > 0 && this.model.partData.count != count) {
      this.model.partData.count = count;
      notifyListeners();
    }
  }
}
