import 'package:flutter/cupertino.dart';
import 'package:jd_learn/config/api.dart';
import 'package:jd_learn/http/request.dart';
import 'package:jd_learn/model/home_model.dart';

class HomePageProvider with ChangeNotifier {
  HomeModel model;
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  loadHomePageData() {
    isLoading = true;
    isError = false;
    errorMsg = "";

    NetRequest().requestData(JdApi.HOME_PAGE).then((res) {
      isLoading = false;
      if (res.code == 200) {
        model = HomeModel.fromJson(res.data);
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
