import 'package:flutter/cupertino.dart';
import 'package:jd_learn/config/api.dart';
import 'package:jd_learn/http/request.dart';

class ProductDetailsProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  loadProductDetailsData() {
    isLoading = true;
    isError = false;
    errorMsg = "";

    NetRequest().requestData(JdApi.PRODUCTIONS_LIST).then((res) {
      isLoading = false;
      print(res.data);
      if (res.code == 200) {}
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
