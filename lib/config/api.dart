class JdApi {
  static const String BASE_URL = 'http://192.168.0.113:5001/api';
  // static const String BASE_URL = 'https://flutter-jdapi.herokuapp.com/api';
  // 首页请求的json数据
  static const String HOME_PAGE = BASE_URL + '/profiles/homepage';
  // 分类页的导航
  static const String CATEGORY_NAV = BASE_URL + '/profiles/navigationLeft';
  // 分类页的商品类目的json数据
  static const String CATEGORY_CONTENT = BASE_URL + '/profiles/navigationRight';
  // 返回的商品列表的json数据
  static const String PRODUCTIONS_LIST = BASE_URL + '/profiles/productionsList';
  // 返回的商品详情的json数据
  static const String PRODUCTIONS_DETAIL =
      BASE_URL + '/profiles/productionDetail';
}
