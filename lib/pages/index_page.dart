import 'package:flutter/material.dart';
import 'package:jd_learn/provider/navigation_bar.dart';
import 'package:provider/provider.dart';

import 'package:jd_learn/pages/home.dart';
import 'package:jd_learn/pages/category.dart';
import 'package:jd_learn/pages/cart.dart';
import 'package:jd_learn/pages/user.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Consumer<BottomNavProvider>(
            builder: (_, mProvider, __) => BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: mProvider.bottomNavIndex,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), title: Text('home')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.category), title: Text('category')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_cart), title: Text('cart')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle), title: Text('user')),
                  ],
                  onTap: (index) {
                    mProvider.changeBottom(index);
                  },
                )),
        body: Consumer<BottomNavProvider>(
            builder: (_, mProviderr, __) => IndexedStack(
                  //层布局控件
                  index: mProviderr.bottomNavIndex,
                  children: <Widget>[
                    HomePage(),
                    CategoryPage(),
                    CartPage(),
                    UserPage(),
                  ],
                )));
  }
}
