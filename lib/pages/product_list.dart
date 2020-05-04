import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_learn/model/product_info.dart';
import 'package:jd_learn/provider/product_detail.dart';
import 'package:jd_learn/provider/product_list.dart';
import 'package:provider/provider.dart';

import 'product_detail.dart';

class ProductList extends StatefulWidget {
  final String title;
  ProductList({Key key, this.title}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("${widget.title}"),
          ),
          body: Container(
              color: Color(0xfff7f7f7),
              child: Consumer<ProductListProvider>(
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
                            provider.loadProductListData();
                          },
                        )
                      ],
                    ));
                  }

                  // 返回数据展示
                  return ListView.builder(
                      itemCount: provider.list.length,
                      itemBuilder: (context, index) {
                        ProductInfoModel model = provider.list[index];

                        // 展示数据
                        return InkWell(
                          child: buildProductRow(model),
                          onTap: () {
                            // 前往商品详情页
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider<
                                        ProductdetailProvider>(
                                      create: (context) {
                                        ProductdetailProvider provider =
                                            ProductdetailProvider();
                                        provider.loadProductData(id: model.id);
                                        return provider;
                                      },
                                      child: Consumer<ProductdetailProvider>(
                                          builder: (_, provider, __) {
                                        return Container(
                                            child: ProductDetailPage(
                                                id: model.id));
                                      }),
                                    )));
                          },
                        );
                      });
                },
              ))),
    );
  }

  // 展示数据
  Row buildProductRow(ProductInfoModel model) {
    return Row(
      children: <Widget>[
        Image.asset(
          "lib/assets${model.cover}",
          width: 95,
          height: 120,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "￥${model.price}",
                style: TextStyle(fontSize: 16.0, color: Color(0xffe93b3d)),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(children: <Widget>[
                Text(
                  "${model.comment}条评价",
                  style: TextStyle(fontSize: 13.0, color: Color(0xff999999)),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "好评率${model.rate}",
                  style: TextStyle(fontSize: 13.0, color: Color(0xff999999)),
                ),
              ]),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ))
      ],
    );
  }
}
