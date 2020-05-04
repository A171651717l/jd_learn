import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_learn/model/category_content_model.dart';
import 'package:jd_learn/pages/product_list.dart';
import 'package:jd_learn/provider/category.dart';
import 'package:jd_learn/provider/product_list.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryPageProvider>(
        create: (context) {
          var provider = new CategoryPageProvider();
          provider.loadCategoryNavData();
          return provider;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('分类'),
          ),
          body: Container(
            color: Colors.grey[200],
            child: Consumer<CategoryPageProvider>(builder: (_, provider, __) {
              // 加载动画
              if (provider.isLoading && provider.categoryNavList.length == 0) {
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
                        provider.loadCategoryNavData();
                      },
                    )
                  ],
                ));
              }

              return Row(children: <Widget>[
                // 分类左侧
                buildLeftContainer(provider),
                // 分类右侧
                Expanded(
                    child: Stack(
                  children: <Widget>[
                    builderCategoryContent(provider.categoryContentList),
                    provider.isLoading
                        ? Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : Container()
                  ],
                ))
              ]);
            }),
          ),
        ));
  }

  // 左侧
  Container buildLeftContainer(CategoryPageProvider provider) {
    return Container(
      width: 90,
      child: ListView.builder(
          itemCount: provider.categoryNavList.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Container(
                  height: 50.0,
                  padding: const EdgeInsets.only(top: 15.0),
                  color: provider.tabIndex == index
                      ? Colors.white
                      : Colors.white24,
                  child: Text(
                    provider.categoryNavList[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: provider.tabIndex == index
                            ? Color(0xFFe93b3d)
                            : Color(0xFF333333),
                        fontWeight: FontWeight.w500),
                  )),
              onTap: () {
                provider.loadCategoryContentData(index);
              },
            );
          }),
    );
  }

  // 右侧
  Widget builderCategoryContent(List<CategoryContentModel> contentList) {
    List<Widget> list = List<Widget>();

    for (var i = 0; i < contentList.length; i++) {
      list.add(Container(
        height: 30.0,
        margin: const EdgeInsets.only(left: 10.0, top: 10.0),
        child: Text(
          "${contentList[i].title}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ));

      List<Widget> descList = List<Widget>();
      for (var j = 0; j < contentList[i].desc.length; j++) {
        descList.add(InkWell(
          child: Container(
              width: 60,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "lib/assets${contentList[i].desc[j].img}",
                    width: 50,
                    height: 50,
                  ),
                  Text("${contentList[i].desc[j].text}")
                ],
              )),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<ProductListProvider>(
                      create: (context) {
                        ProductListProvider provider = ProductListProvider();
                        provider.loadProductListData();
                        return provider;
                      },
                      child: Consumer<ProductListProvider>(
                          builder: (_, provider, __) {
                        return Container(
                            child: ProductList(
                                title: contentList[i].desc[j].text));
                      }),
                    )));
          },
        ));
      }
      list.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 7.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.start,
          children: descList,
        ),
      ));
    }
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: ListView(
        children: list,
      ),
    );
  }
}
