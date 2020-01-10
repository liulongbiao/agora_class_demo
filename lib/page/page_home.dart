import 'package:flutter/material.dart';

import 'page_classroom.dart';

/// 主页面
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('进入课堂'),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (content) => PageClassroom(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
