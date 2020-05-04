import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:jd_learn/model/home_model.dart';
import 'package:jd_learn/provider/home.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageProvider>(
        create: (context) {
          var provider = new HomePageProvider();
          provider.loadHomePageData();
          return provider;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('首页'),
          ),
          body: Container(
            color: Colors.grey[200],
            child: Consumer<HomePageProvider>(builder: (_, provider, __) {
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
                        provider.loadHomePageData();
                      },
                    )
                  ],
                ));
              }

              HomeModel model = provider.model;

              return ListView(
                children: <Widget>[
                  // banner
                  buildAspectRatio(model),
                  // 图标分类
                  buildLogos(model),
                  // 掌上秒杀头部
                  buildHeaderContainer(),
                  // 掌上秒杀
                  buildBodyContainer(model),
                  // 广告1
                  buildAds(model.pageRow.ad1),
                  // 广告2
                  buildAds(model.pageRow.ad2),
                ],
              );
            }),
          ),
        ));
  }

  // banner
  AspectRatio buildAspectRatio(HomeModel model) {
    return AspectRatio(
      aspectRatio: 72 / 35,
      child: Swiper(
        itemCount: model.swipers.length,
        pagination: SwiperPagination(),
        autoplay: true,
        control: new SwiperControl(),
        itemBuilder: (BuildContext content, int index) {
          return Image.asset("lib/assets${model.swipers[index].image}");
        },
      ),
    );
  }

  // 图标分类
  Widget buildLogos(HomeModel model) {
    List<Widget> list = List<Widget>();
    for (var i = 0; i < model.logos.length; i++) {
      list.add(Container(
        width: 60.0,
        child: Column(children: <Widget>[
          Image.asset(
            "lib/assets${model.logos[i].image}",
            width: 50,
            height: 50,
          ),
          Text("${model.logos[i].title}")
        ]),
      ));
    }
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      color: Colors.white,
      height: 170,
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        spacing: 7.0,
        runSpacing: 10.0,
        alignment: WrapAlignment.spaceBetween,
        children: list,
      ),
    );
  }

  // 掌上秒杀头部
  Container buildHeaderContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(10.0),
      color: Colors.white,
      height: 50,
      child: Row(
        children: <Widget>[
          Image.asset("lib/assets/image/bej.png", width: 90, height: 20),
          Spacer(),
          Text("更多秒杀"),
          Icon(
            CupertinoIcons.right_chevron,
            size: 14,
          )
        ],
      ),
    );
  }

  // 掌上秒杀
  Container buildBodyContainer(HomeModel model) {
    return Container(
      height: 120,
      color: Colors.white,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: model.quicks.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "lib/assets${model.quicks[index].image}",
                    width: 85,
                    height: 85,
                  ),
                  Text(
                    "${model.quicks[index].price}",
                    style: TextStyle(color: Colors.red, fontSize: 16.0),
                  )
                ],
              ),
            );
          }),
    );
  }

  // 广告
  Widget buildAds(List<String> ads) {
    List<Widget> list = List<Widget>();
    for (var i = 0; i < ads.length; i++) {
      list.add(Expanded(
        child: Image.asset("lib/assets${ads[i]}"),
      ));
    }

    return Container(
        margin: const EdgeInsets.only(top: 10.0), child: Row(children: list));
  }
}
