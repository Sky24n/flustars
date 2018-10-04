import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    test();
  }

  void test() async {
    SpUtil spUtil = await SpUtil.getInstance();
    //SpUtil.remove("username");
    SpUtil.putString("username", "sky224");
    print("username: " + SpUtil.getString("username").toString());
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('Running on: '),
        ),
      ),
    );
  }
}
