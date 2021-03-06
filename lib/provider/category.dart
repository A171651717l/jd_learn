import 'package:flutter/cupertino.dart';

import 'package:jd_learn/config/api.dart';
import 'package:jd_learn/http/request.dart';
import 'package:jd_learn/model/category_content_model.dart';

class CategoryPageProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  List<String> categoryNavList = [];
  List<CategoryContentModel> categoryContentList = [];
  int tabIndex = 0;

  // 分类左侧
  loadCategoryNavData() {
    isLoading = true;
    isError = false;
    errorMsg = "";

    NetRequest().requestData(JdApi.CATEGORY_NAV).then((res) {
      isLoading = false;
      if (res.data is List) {
        for (var i = 0; i < res.data.length; i++) {
          categoryNavList.add(res.data[i]);
        }
        loadCategoryContentData(tabIndex);
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

  // 分类右侧
  loadCategoryContentData(int index) {
    tabIndex = index;
    isLoading = true;
    // isError = false;
    // errorMsg = "";
    categoryContentList.clear();

    var data = {'title': categoryNavList[index]};
    NetRequest()
        .requestData(JdApi.CATEGORY_CONTENT, data: data, method: 'post')
        .then((res) {
      isLoading = false;
      if (res.data is List) {
        for (var item in res.data) {
          CategoryContentModel tmpModel = CategoryContentModel.fromJson(item);
          categoryContentList.add(tmpModel);
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

    notifyListeners();
  }
}
