import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jd_learn/provider/cart.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // 保留一个slidable打开
  final SlidableController _slidableController = SlidableController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('购物车')),
      body: Consumer<CartProvider>(
        builder: (_, provider, __) {
          if (provider.models.length == 0) {
            return Center(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Image.asset("lib/assets/image/shop_cart.png",
                      width: 90.0, height: 90.0),
                ),
                Text("购物车空空如也，去逛逛吧~",
                    style: TextStyle(fontSize: 16.0, color: Color(0xff999999)))
              ],
            ));
          } else {
            return Stack(
              children: <Widget>[
                // 商品列表
                ListView.builder(
                    itemCount: provider.models.length,
                    itemBuilder: (context, index) {
                      return buildProductItem(provider, index);
                    }),
                // 底部菜单栏
                buildPositionedBottom(provider)
              ],
            );
          }
        },
      ),
    );
  }

  Positioned buildPositionedBottom(CartProvider provider) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(width: 1, color: Colors.grey[300]),
                bottom: BorderSide(width: 1, color: Color(0xffe8e8ed)))),
        child: Row(children: <Widget>[
          InkWell(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Image.asset(
                    provider.isSelectAll
                        ? "lib/assets/image/selected.png"
                        : "lib/assets/image/unselect.png",
                    width: 20.0,
                    height: 20.0),
              ),
              onTap: () {
                provider.handleSelectAll();
              }),
          Text(
            "全选",
            style: TextStyle(color: Color(0xff999999)),
          ),
          SizedBox(width: 10.0),
          Text(
            "合计:",
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            "￥${provider.getAmount()}",
            style: TextStyle(
                fontSize: 16.0,
                color: Color(0xffe4393c),
                fontWeight: FontWeight.w500),
          ),
          Spacer(),
          Container(
              width: 120.0,
              height: double.infinity,
              color: Color(0xffe4393c),
              child: Center(
                child: Text(
                  "去结算(${provider.getSelectedCount()})",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0),
                ),
              ))
        ]),
      ),
    );
  }

  Widget buildProductItem(CartProvider provider, int index) {
    return Slidable(
      controller: _slidableController,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      // 右侧action
      secondaryActions: <Widget>[
        SlideAction(
          child: Center(
            child: Text("删除",
                style: TextStyle(color: Colors.white, fontSize: 16.0)),
          ),
          color: Color(0xffe4393c),
          onTap: () {
            provider.removeFromCart(provider.models[index].id);
          },
        )
      ],
      child: Row(
        children: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                  provider.models[index].isSelected
                      ? "lib/assets/image/selected.png"
                      : "lib/assets/image/unselect.png",
                  width: 20.0,
                  height: 20.0),
            ),
            onTap: () {
              provider.handleSelectById(provider.models[index].id);
            },
          ),
          Expanded(
              child: Card(
            margin: EdgeInsets.all(8.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Image.asset(
                          "lib/assets${provider.models[index].loopImgUrl[0]}",
                          width: 90.0,
                          height: 90.0)),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(provider.models[index].title,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w400),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(children: <Widget>[
                        Text(
                          "￥${provider.models[index].price}",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffe93b3d)),
                        ),
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
                                        color: provider.models[index].count == 1
                                            ? Color(0xffb0b0b0)
                                            : Colors.black))),
                          ),
                          onTap: () {
                            if (provider.models[index].count > 1) {
                              provider.models[index].count -= 1;
                              provider.addToCart(provider.models[index]);
                            }
                          },
                        ),
                        SizedBox(width: 2.0),
                        Container(
                            width: 35.0,
                            height: 35.0,
                            child: Center(
                              child: Text("${provider.models[index].count}"),
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
                                          color: Colors.black))),
                            ),
                            onTap: () {
                              provider.models[index].count += 1;
                              provider.addToCart(provider.models[index]);
                            }),
                      ])
                    ],
                  ))
                ]),
          ))
        ],
      ),
    );
  }
}
