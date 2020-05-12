import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';

class WebsocketTest extends StatefulWidget {
  WebsocketTest({Key key}) : super(key: key);

  @override
  _WebsocketTestState createState() => _WebsocketTestState();
}

class _WebsocketTestState extends State<WebsocketTest> {
  final channel = IOWebSocketChannel.connect('ws://47.112.131.225:8081');
  String _text = "";
  String socketMsg = '';
  int count = 0;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebsocketTest"),
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: 'Send a message'),
                ),
              ),
              StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  print(snapshot);
                  count++;
                  if (snapshot.hasError) {
                    _text = "network error";
                  } else if (snapshot.hasData) {
                    socketMsg = json.decode(snapshot.data)['args'][0];
                    var socketMap = base64.decode(socketMsg);
                    var decodedData = gzip.decode(socketMap);
                    _text = utf8.decode(decodedData, allowMalformed: true);
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'No.$count',
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(_text),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send Socket Messages',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    var jsonData = {
      "command": "sub.depth",
      "args": ["ethusdt", 0, 100]
    };
    channel.sink.add(json.encode(jsonData));
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
