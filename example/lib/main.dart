import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
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
      home: new MainPage(),
    );

//    return new MaterialApp(
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: const Text('Plugin example app'),
//        ),
//        body: new Center(
//          child: new Text('username: $_userName'),
//        ),
//        floatingActionButton: new FloatingActionButton(onPressed: () {
//          Navigator.push(
//              context, new CupertinoPageRoute(builder: (ctx) => TestPage()));
//        }),
//      ),
//    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  WidgetUtil widgetUtil = new WidgetUtil();

  @override
  void initState() {
    super.initState();

    DioUtil.openDebug(); //打开debug模式

    Options options = DioUtil.getDefOptions();
    options.baseUrl = "http://www.wanandroid.com/";
    HttpConfig config = new HttpConfig(options: options);
    DioUtil().setConfig(config);

    DioUtil()
        .request<List>(Method.get, "banner/json")
        .then((BaseResp<List> resp) {
      print("BaseResp: " + resp.toString());
    });

    widgetUtil.asyncPrepares(true, (_) {
      print("Widget 渲染完成...");
    });
  }

  @override
  Widget build(BuildContext context) {
    // 如果使用ScreenUtil.getInstance() 需要MainPageState build 调用MediaQuery.of(context)
    MediaQuery.of(context);

    double width = ScreenUtil.getInstance().screenWidth;
    double height = ScreenUtil.getInstance().screenHeight;
    double density = ScreenUtil.getInstance().screenDensity;
    double tempW = ScreenUtil.getInstance().getWidth(360.0);
    double tempH = ScreenUtil.getInstance().getHeight(360.0);
    double textScaleFactor =
        ScreenUtil.getInstance().mediaQueryData.textScaleFactor;

    print(
        "width: $width, height: $height, density: $density, tempW: $tempW, tempH: $tempH, textScaleFactor: $textScaleFactor");
    double _width = width * density;
    double _height = height * density;
    double __tempW = ScreenUtil.getInstance().getWidthPx(90.0);
    print(
        "_width: $_width, height: $_height, __tempW: $__tempW, tempW: $tempW, tempH: $tempH");

    return new Scaffold(
      appBar: new AppBar(),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            width: 360.0,
            height: 50,
            color: Colors.grey,
            child: new Center(
              child: new Text(
                "你好你好你好",
                style: new TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          new Container(
            width: ScreenUtil.getInstance().getWidth(360.0),
            height: 50,
            color: Colors.grey,
            child: new Center(
              child: new Text(
                "你好你好你好",
                style: new TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          new Container(
            width: 100,
            height: 100,
            color: Colors.grey,
            child: new Center(
              child: new Text(
                "你好你好你好",
                style: new TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            width: ScreenUtil.getInstance().getWidth(100.0),
            height: ScreenUtil.getInstance().getHeight(100.0),
            color: Colors.grey,
            child: new Center(
              child: new Text(
                "你好你好你好",
                style: new TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            width: ScreenUtil.getInstance().getWidth(100.0),
            height: ScreenUtil.getInstance().getHeight(100.0),
            color: Colors.grey,
            child: new Center(
              child: new Text(
                "你好你好你好",
                style: new TextStyle(
                    fontSize: ScreenUtil.getInstance().getSp(24.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TestPageState();
  }
}

class TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    double width = ScreenUtil.getInstance().screenWidth;
    double height = ScreenUtil.getInstance().screenHeight;

    print("width: $width, height: $height");

    return new Scaffold(
      body: new AppBar(),
    );
  }
}
