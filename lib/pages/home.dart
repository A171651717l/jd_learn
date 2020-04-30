import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_learn/config/api.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NetRequest();
    return Scaffold(
      appBar: AppBar(title: Text('home')),
      body: Container(),
    );
  }
}

NetRequest() async {
  var dio = Dio();
  Response response = await dio.get(JdApi.HOME_PAGE);
  print(response.data);
}
