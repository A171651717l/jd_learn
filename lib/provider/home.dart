import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jd_learn/config/api.dart';
import 'package:jd_learn/http/request.dart';
import 'package:jd_learn/model/bituan_test.dart';
import 'package:jd_learn/model/home_model.dart';

class HomePageProvider with ChangeNotifier {
  HomeModel model;
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  List<BituanModel> list = List();
  BituanModel bituanModel;

  loadHomePageData() {
    isLoading = true;
    isError = false;
    errorMsg = "";
    var dio = Dio();

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

    // HttpRequest().dio.get('http://wapi.ipfz.tv:81/v1/symbolConfig/findAll').then((res) {
    //   isLoading = false;
    //   bituanModel = BituanModel.fromJson(json.decode(res.data));
    //   notifyListeners();
    // }).catchError((error) {
    //   print('error BituanModel 1>>>>> $error');
    //   isError = true;
    //   errorMsg = error;
    //   isLoading = false;
    //   notifyListeners();
    // });
  }
}
