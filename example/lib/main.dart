import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
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

    /// 配置设计稿尺寸
    /// 如果设计稿尺寸默认配置一致，无需该设置。默认 width:360.0 / height:640.0 / density:3.0
    setDesignWHD(360.0, 640, density: 3);

    _initAsync();
  }

  void _initAsync() async {
    print("SpUtil: " + SpUtil.isInitialized().toString());
    await SpUtil.getInstance();
    print("SpUtil: " + SpUtil.isInitialized().toString());
    SpUtil.putString("username", "sky24");
    print("username: " + SpUtil.getString("username").toString());
    if (!mounted) return;
    setState(() {
      String _userName = SpUtil.getString("username");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 如果使用ScreenUtil.getInstance()
    // 需要MainPageState build 调用MediaQuery.of(context)
//    MediaQuery.of(context);

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
      // 一个不需要GlobalKey就可以openDrawer的AppBar
      appBar: new MyAppBar(
        leading: ClipOval(
          child: new Image.asset(('assets/images/ali_connors.png')),
        ),
        title: const Text('Flustars Demos'),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
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
      drawer: new Container(
        color: Colors.white,
        width: ScreenUtil.getInstance().getWidth(100),
        height: double.infinity,
        child: new SizedBox(
          width: ScreenUtil.getInstance().getWidth(100),
        ),
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
