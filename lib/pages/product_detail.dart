import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_learn/provider/cart.dart';
import 'package:jd_learn/provider/navigation_bar.dart';
import 'package:provider/provider.dart';

import 'package:jd_learn/provider/product_detail.dart';
import 'package:jd_learn/model/product_detail_model.dart';

class ProductDetailPage extends StatefulWidget {
  final String id;
  ProductDetailPage({Key key, this.id}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('详情页'),
        ),
        body: Container(
          color: Colors.grey[200],
          child: Consumer<ProductdetailProvider>(
            builder: (_, provider, __) {
              // 加载动画
              if (provider.isLoading) {
                return Center(child: CupertinoActivityIndicator());
              }

              // 捕获异常
              if (provider.isError) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(provider.errorMsg),
                    OutlineButton(
                      child: Text("刷新"),
                      onPressed: () {
                        provider.loadProductData(id: widget.id);
                      },
                    )
                  ],
                ));
              }

              // 获取model
              ProductDetailModel model = provider.model;
              String baitiaoTile = "【白条支付】首单享立减优惠";

              for (var item in model.baitiao) {
                if (item.select == true) {
                  baitiaoTile = item.desc;
                }
              }

              return Stack(children: <Widget>[
                // 主体内容
                ListView(
                  children: <Widget>[
                    // 轮播图
                    buildSwiperContainer(model),
                    // 标题
                    buildTileContainer(model),
                    // 价格
                    buildPriceContainer(model),
                    // 白条
                    buildPayContainer(context, baitiaoTile, model, provider),
                    // 件数
                    buildCountContainer(context, model, provider),
                  ],
                ),

                // 底部菜单
                buildBottomContainer(context, model)
              ]);
            },
          ),
        ),
      ),
    );
  }

  Container buildCountContainer(BuildContext context, ProductDetailModel model,
      ProductdetailProvider provider) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(width: 1, color: Color(0xffe8e8ed)),
              bottom: BorderSide(width: 1, color: Color(0xffe8e8ed)))),
      child: InkWell(
          child: Row(children: <Widget>[
            Text("已选", style: TextStyle(color: Color(0xff999999))),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text("${model.partData.count}件")),
            ),
            Icon(Icons.more_horiz)
          ]),
          onTap: () {
            return showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return ChangeNotifierProvider.value(
                    value: provider,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          height: double.infinity,
                          margin: EdgeInsets.only(top: 25),
                        ),
                        // 顶部：图片 价格 数量
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: Image.asset(
                                    "lib/assets${model.partData.loopImgUrl[0]}"),
                                width: 120.0,
                                height: 100.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 35.0,
                                  ),
                                  Text(
                                    "￥${model.partData.price}",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffe93b3d)),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text("已选${model.partData.count}")
                                ],
                              ),
                              Spacer(),
                              Container(
                                  margin: EdgeInsets.only(top: 25.0),
                                  child: IconButton(
                                    icon: Icon(Icons.close),
                                    iconSize: 20.0,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ))
                            ]),
                        // 中间：数量 加减号
                        Container(
                          margin: EdgeInsets.only(top: 90.0, bottom: 50.0),
                          padding: EdgeInsets.only(top: 40.0, left: 15.0),
                          child: Consumer<ProductdetailProvider>(
                              builder: (_, provider, __) {
                            return Row(children: <Widget>[
                              Text("数量"),
                              Spacer(),
                              InkWell(
                                child: Container(
                                  width: 35.0,
                                  height: 35.0,
                                  color: Colors.grey[200],
                                  child: Center(
                                      child: Text("-",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Color(0xffb0b0b0)))),
                                ),
                                onTap: () {
                                  int tmpCount = model.partData.count;
                                  tmpCount--;
                                  provider.changeProductCount(tmpCount);
                                },
                              ),
                              SizedBox(width: 2.0),
                              Container(
                                  width: 35.0,
                                  height: 35.0,
                                  child: Center(
                                    child: Text("${model.partData.count}"),
                                  )),
                              SizedBox(
                                width: 2.0,
                              ),
                              InkWell(
                                  child: Container(
                                    width: 35.0,
                                    height: 35.0,
                                    color: Colors.grey[200],
                                    child: Center(
                                        child: Text("+",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Color(0xffb0b0b0)))),
                                  ),
                                  onTap: () {
                                    int tmpCount = model.partData.count;
                                    tmpCount++;
                                    provider.changeProductCount(tmpCount);
                                  }),
                              SizedBox(
                                width: 10.0,
                              )
                            ]);
                          }),
                        ),
                        // 底部：按钮
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            child: Container(
                              height: 50.0,
                              color: Color(0xffe93b3d),
                              alignment: Alignment.center,
                              child: Text("加入购物车",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            onTap: () {
                              // 加入购物车
                              Provider.of<CartProvider>(context, listen: false)
                                  .addToCart(model.partData);
                              Fluttertoast.cancel();
                              Fluttertoast.showToast(
                                  msg: "成功加入购物车",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }

  Container buildPayContainer(BuildContext context, String baitiaoTile,
      ProductDetailModel model, ProductdetailProvider provider) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(width: 1, color: Color(0xffe8e8ed)),
              bottom: BorderSide(width: 1, color: Color(0xffe8e8ed)))),
      child: InkWell(
          child: Row(children: <Widget>[
            Text("支付", style: TextStyle(color: Color(0xff999999))),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text("$baitiaoTile")),
            ),
            Icon(Icons.more_horiz)
          ]),
          onTap: () {
            buildBaitiao(context, model, provider);
          }),
    );
  }

  Future buildBaitiao(BuildContext context, ProductDetailModel model,
      ProductdetailProvider provider) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ChangeNotifierProvider<ProductdetailProvider>.value(
            value: provider,
            child: Stack(
              children: <Widget>[
                // 顶部标题栏
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 40.0,
                      color: Color(0xfff3f2f8),
                      child: Center(
                        child: Text(
                          "打白条购买",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      width: 40.0,
                      height: 40.0,
                      child: Center(
                          child: IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 20,
                        onPressed: () {
                          // 关闭
                          Navigator.pop(context);
                        },
                      )),
                    )
                  ],
                ),
                // 主体列表
                Container(
                    margin: const EdgeInsets.only(top: 40.0, bottom: 50.0),
                    child: ListView.builder(
                      itemCount: model.baitiao.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Consumer<ProductdetailProvider>(
                                    builder: (_, tempProvider, __) {
                                  return Image.asset(
                                    model.baitiao[index].select
                                        ? "lib/assets/image/selected.png"
                                        : "lib/assets/image/unselect.png",
                                    width: 20,
                                    height: 20,
                                  );
                                }),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0, left: 8.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("${model.baitiao[index].desc}"),
                                        Text("${model.baitiao[index].tip}")
                                      ]))
                            ],
                          ),
                          onTap: () {
                            provider.changeBaitiaoSelected(index);
                          },
                        );
                      },
                    )),
                // 底部按钮
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      color: Color(0xffe4393c),
                      child: Center(
                        child: Text(
                          "立即打白条",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  Container buildPriceContainer(ProductDetailModel model) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: Text(
        "￥${model.partData.price}",
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xffe93b3d)),
      ),
    );
  }

  Container buildTileContainer(ProductDetailModel model) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: Text(model.partData.title,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
    );
  }

  Container buildSwiperContainer(ProductDetailModel model) {
    return Container(
      color: Colors.white,
      height: 400,
      child: Swiper(
        itemCount: model.partData.loopImgUrl.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            "lib/assets${model.partData.loopImgUrl[index]}",
            width: double.infinity,
            height: 400,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }

  Positioned buildBottomContainer(
      BuildContext context, ProductDetailModel model) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 1.0, color: Color(0xffe8e8ed)))),
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                                width: 40.0,
                                height: 30.0,
                                child: Icon(Icons.shopping_cart)),
                            Consumer<CartProvider>(
                                builder: (_, cartProvider, __) {
                              return Positioned(
                                  right: 0.0,
                                  child: cartProvider.getAllCount() > 0
                                      ? Container(
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(11.0)),
                                          child: Text(
                                              "${cartProvider.getAllCount()}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.0)),
                                        )
                                      : Container());
                            })
                          ],
                        ),
                        Text("购物车", style: TextStyle(fontSize: 13.0))
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                    Provider.of<BottomNavProvider>(context, listen: false)
                        .changeBottom(2);
                  },
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                      height: 60,
                      color: Color(0xffe93b3d),
                      alignment: Alignment.center,
                      child: Text("加入购物车",
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                  onTap: () {
                    // 加入购物车
                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(model.partData);
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg: "成功加入购物车",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        fontSize: 16.0);
                  },
                ),
              ),
            ],
          )),
    );
  }
}
