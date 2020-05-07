class BituanModel {
  num status;
  String message;
  Null error;
  List<Data> data;
  String type;
  String timestamp;
  bool success;

  BituanModel(
      {this.status,
      this.message,
      this.error,
      this.data,
      this.type,
      this.timestamp,
      this.success});

  BituanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    type = json['type'];
    timestamp = json['timestamp'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['timestamp'] = this.timestamp;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String symbol;
  String baseCoin;
  String quoteCoin;
  num openPrice;
  num upPriceRange;
  num downPriceRange;
  num feeRate;
  num takerFeeRate;
  num makerFeeRate;
  num priceRange;
  num pricePrecision;
  num volumePrecision;
  String depthPrecisionList;
  num minPrice;
  num minVolume;
  num minAmount;
  num buyMaxVolume;
  num sellMaxVolume;
  bool special;
  bool fresh;
  bool hide;
  bool hot;
  Null plan;
  bool free;
  Null hideMarket;
  bool riskWarn;
  num weight;
  String symbolType;
  String symbolTypeName;
  bool enabledMarket;
  bool enabledLimit;
  String openDate;
  List<DepthList> depthList;

  Data(
      {this.symbol,
      this.baseCoin,
      this.quoteCoin,
      this.openPrice,
      this.upPriceRange,
      this.downPriceRange,
      this.feeRate,
      this.takerFeeRate,
      this.makerFeeRate,
      this.priceRange,
      this.pricePrecision,
      this.volumePrecision,
      this.depthPrecisionList,
      this.minPrice,
      this.minVolume,
      this.minAmount,
      this.buyMaxVolume,
      this.sellMaxVolume,
      this.special,
      this.fresh,
      this.hide,
      this.hot,
      this.plan,
      this.free,
      this.hideMarket,
      this.riskWarn,
      this.weight,
      this.symbolType,
      this.symbolTypeName,
      this.enabledMarket,
      this.enabledLimit,
      this.openDate,
      this.depthList});

  Data.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    baseCoin = json['baseCoin'];
    quoteCoin = json['quoteCoin'];
    openPrice = json['openPrice'];
    upPriceRange = json['upPriceRange'];
    downPriceRange = json['downPriceRange'];
    feeRate = json['feeRate'];
    takerFeeRate = json['takerFeeRate'];
    makerFeeRate = json['makerFeeRate'];
    priceRange = json['priceRange'];
    pricePrecision = json['pricePrecision'];
    volumePrecision = json['volumePrecision'];
    depthPrecisionList = json['depthPrecisionList'];
    minPrice = json['minPrice'];
    minVolume = json['minVolume'];
    minAmount = json['minAmount'];
    buyMaxVolume = json['buyMaxVolume'];
    sellMaxVolume = json['sellMaxVolume'];
    special = json['special'];
    fresh = json['fresh'];
    hide = json['hide'];
    hot = json['hot'];
    plan = json['plan'];
    free = json['free'];
    hideMarket = json['hideMarket'];
    riskWarn = json['riskWarn'];
    weight = json['weight'];
    symbolType = json['symbolType'];
    symbolTypeName = json['symbolTypeName'];
    enabledMarket = json['enabledMarket'];
    enabledLimit = json['enabledLimit'];
    openDate = json['openDate'];
    if (json['depthList'] != null) {
      depthList = new List<DepthList>();
      json['depthList'].forEach((v) {
        depthList.add(new DepthList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['baseCoin'] = this.baseCoin;
    data['quoteCoin'] = this.quoteCoin;
    data['openPrice'] = this.openPrice;
    data['upPriceRange'] = this.upPriceRange;
    data['downPriceRange'] = this.downPriceRange;
    data['feeRate'] = this.feeRate;
    data['takerFeeRate'] = this.takerFeeRate;
    data['makerFeeRate'] = this.makerFeeRate;
    data['priceRange'] = this.priceRange;
    data['pricePrecision'] = this.pricePrecision;
    data['volumePrecision'] = this.volumePrecision;
    data['depthPrecisionList'] = this.depthPrecisionList;
    data['minPrice'] = this.minPrice;
    data['minVolume'] = this.minVolume;
    data['minAmount'] = this.minAmount;
    data['buyMaxVolume'] = this.buyMaxVolume;
    data['sellMaxVolume'] = this.sellMaxVolume;
    data['special'] = this.special;
    data['fresh'] = this.fresh;
    data['hide'] = this.hide;
    data['hot'] = this.hot;
    data['plan'] = this.plan;
    data['free'] = this.free;
    data['hideMarket'] = this.hideMarket;
    data['riskWarn'] = this.riskWarn;
    data['weight'] = this.weight;
    data['symbolType'] = this.symbolType;
    data['symbolTypeName'] = this.symbolTypeName;
    data['enabledMarket'] = this.enabledMarket;
    data['enabledLimit'] = this.enabledLimit;
    data['openDate'] = this.openDate;
    if (this.depthList != null) {
      data['depthList'] = this.depthList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DepthList {
  num type;
  num precision;
  String name;
  num value;

  DepthList({this.type, this.precision, this.name, this.value});

  DepthList.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    precision = json['precision'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['precision'] = this.precision;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}
