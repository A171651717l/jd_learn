import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jd_learn/model/home_model.dart';

import 'package:jd_learn/store/home.dart';
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
            title: Text('homePage'),
          ),
          body: Container(
            color: Color(0xFFf4f4f4),
            child: Consumer<HomePageProvider>(builder: (_, provider, __) {
              // print(provider.isLoading);
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

              // return Container();
              HomeModel model = provider.model;

              return Swiper(
                itemCount: model.swipers.length,
                pagination: SwiperPagination(),
                autoplay: true,
                itemBuilder: (BuildContext content, int index) {
                  return Image.asset("assets${model.swipers[index].image}");
                },
              );
            }),
          ),
        ));
  }
}
