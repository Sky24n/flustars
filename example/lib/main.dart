import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    test();
  }

  void test() async {
    print("SpUtil: " + SpUtil.isInitialized().toString());
    SpUtil spUtil = await SpUtil.getInstance();
    //SpUtil.remove("username");
    print("SpUtil: " + SpUtil.isInitialized().toString());
    SpUtil.putString("username", "sky24");
    print("username: " + SpUtil.getString("username").toString());
    if (!mounted) return;
    setState(() {
      _userName = SpUtil.getString("username");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('username: $_userName'),
        ),
      ),
    );
  }
}
