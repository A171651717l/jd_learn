import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jd_learn/pages/index_page.dart';
import 'package:jd_learn/store/navigation_bar.dart';

void main() => runApp(
      ChangeNotifierProvider.value(
        value: BottomNavProvider(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }
}
