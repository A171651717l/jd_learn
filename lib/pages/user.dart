import 'package:flutter/material.dart';
import 'package:jd_learn/pages/webview.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
            // 头部
            buildHeaderContainer(),
            // 订单
            buildOrderContainer(),
            // 资产
            buildAssetsContainer(),
            // 店铺
            buildStoreContainer()
          ],
        ),
      ),
    );
  }

  Container buildStoreContainer() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                '10',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '商品收藏',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '2',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '店铺收藏',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '0',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '搭配收藏',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '0',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '我的足迹',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildAssetsContainer() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '2',
                    style: TextStyle(fontSize: 22, color: Color(0xFFE8272B)),
                  ),
                  Text(
                    '张',
                    style: TextStyle(fontSize: 12, color: Color(0xFFE8272B)),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '京东劵',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '0',
                    style: TextStyle(fontSize: 22, color: Color(0xFFE8272B)),
                  ),
                  Text(
                    '元',
                    style: TextStyle(fontSize: 12, color: Color(0xFFE8272B)),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '账户余额',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '40',
                    style: TextStyle(fontSize: 22, color: Color(0xFFE8272B)),
                  ),
                  Text(
                    '个',
                    style: TextStyle(fontSize: 12, color: Color(0xFFE8272B)),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '京豆',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '0',
                    style: TextStyle(fontSize: 22, color: Color(0xFFE8272B)),
                  ),
                  Text(
                    '元',
                    style: TextStyle(fontSize: 12, color: Color(0xFFE8272B)),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '红包',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Image.asset(
            "lib/assets/image/ahv.png",
            width: 5.2,
            height: 44.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Color(0xFFE51E1F),
                  )),
              Text('我的资产', style: TextStyle(color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  Container buildOrderContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      color: (Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 50,
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Icon(
                      Icons.payment,
                      color: Color(0xFFDB9D58),
                    )),
                Text('待付款', style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Icon(
                    Icons.airport_shuttle,
                    color: Color(0xFFDB9D58),
                  )),
              Text('待收货', style: TextStyle(color: Colors.black54)),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Icon(
                    Icons.chat,
                    color: Color(0xFFDB9D58),
                  )),
              Text('待评价', style: TextStyle(color: Colors.black54)),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Icon(
                    Icons.monetization_on,
                    color: Color(0xFFDB9D58),
                  )),
              Text('退款/售后', style: TextStyle(color: Colors.black54)),
            ],
          ),
          Image.asset(
            "lib/assets/image/ahv.png",
            width: 5.2,
            height: 44.0,
          ),
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Icon(
                    Icons.featured_play_list,
                    color: Color(0xFFE51E1F),
                  )),
              Text('全部订单', style: TextStyle(color: Colors.black54)),
              Text('查看发票',
                  style: TextStyle(fontSize: 11, color: Colors.black12)),
            ],
          ),
        ],
      ),
    );
  }

  Container buildHeaderContainer() {
    bool flag = true;
    void _toggleFavorite() {}
    ;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xffe43b3a), Color(0xfff07157)])),
      height: 140,
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 36.0,
                  backgroundImage: AssetImage("lib/assets/image/me-hl.png"),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("zhuzhilong",
                              style: TextStyle(
                                  fontSize: 14.0, color: Color(0xfffde5e3))),
                          Container(
                              margin: const EdgeInsets.only(left: 8.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Icon(
                                Icons.edit,
                                size: 12.0,
                                color: Colors.red,
                              ))
                        ],
                      ),
                      Text(
                        "用户名：鱼遇雨欲语与余",
                        style:
                            TextStyle(color: Color(0xfffabbb7), fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Row(children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              top: 2.0, bottom: 5.0, left: 8.0, right: 4.0),
                          decoration: BoxDecoration(
                              color: Color(0xffc74a3d),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Row(children: <Widget>[
                            Text("京享值6548",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white)),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 16.0,
                            ),
                          ]),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 2.0, bottom: 5.0, left: 8.0, right: 4.0),
                          decoration: BoxDecoration(
                              color: Color(0xffc74a3d),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Row(children: <Widget>[
                            Text("小白信用990",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white)),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 16.0,
                            ),
                          ]),
                        ),
                      ])
                    ])
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 20.0,
            right: 20.0,
            child: Container(
              height: 40.0,
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  )),
              child: Row(children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 5.0),
                  child: Icon(
                    Icons.view_compact,
                    color: Colors.yellow,
                    size: 16,
                  ),
                ),
                Text("PLUS",
                    style: TextStyle(color: Colors.yellow, fontSize: 18.0)),
                Container(
                    height: 10.0,
                    width: 1.0,
                    color: Colors.yellow,
                    margin: const EdgeInsets.all(8.0)),
                Text(
                  "每月5张运费券",
                  style: TextStyle(color: Colors.yellow, fontSize: 16.0),
                ),
                Spacer(),
                InkWell(
                  child: Text("立即查看",
                      style: TextStyle(color: Colors.yellow, fontSize: 16.0)),
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new WebViewExample(),
                      ),
                    );
                  },
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.yellow,
                  size: 16,
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
