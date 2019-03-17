import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class City {
  String name;

  City({this.name});

  /// must.
  City.fromJson(Map<String, dynamic> json) : name = json['name'];

  /// must.
  Map<String, dynamic> toJson() => {
        'name': name,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"name\":\"$name\"");
    sb.write('}');
    return sb.toString();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initAsync();

    /// 配置设计稿尺寸
    /// 如果设计稿尺寸默认配置一致，无需该设置。默认 width:360.0 / height:640.0 / density:3.0
    /// Configuration design draft size.
    /// If the default configuration of design draft size is the same, this setting is not required. default width:360.0 / height:640.0 / density:3.0
    setDesignWHD(360.0, 640.0, density: 3);
  }

  /// SpUtil example.
  void _initAsync() async {
    await SpUtil.getInstance();

    SpUtil.putString("username", "sky24");
    String userName = SpUtil.getString("username", defValue: "");
    print("thll userName: " + userName);

    /// save object example.
    /// 存储实体对象示例。
    City city = new City();
    city.name = "成都市";
    SpUtil.putObject("loc_city", city);

    Map dataStr = SpUtil.getObject("loc_city");
    City hisCity = dataStr == null ? null : City.fromJson(dataStr);
    print("thll Str: " + (hisCity == null ? "null" : hisCity.toString()));

    /// save object list example.
    /// 存储实体对象list示例。
    List<City> list = new List();
    list.add(new City(name: "成都市"));
    list.add(new City(name: "北京市"));
    SpUtil.putObjectList("loc_city_list", list);

    List<Map> dataList = SpUtil.getObjectList("loc_city_list");
    List<City> _cityList = dataList?.map((value) {
      return City.fromJson(value);
    })?.toList();

    print("thll List: " + (_cityList == null ? "null" : _cityList.toString()));
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

/// 在MainPage使用依赖不context方法获取屏幕参数及适配，需要build方法内调用[MediaQuery.of(context)]。
/// 或者使用依赖context方法获取屏幕参数及适配。
/// In MainPage, the dependency-free context method is used to obtain screen parameters and adaptions, which requires a call to [MediaQuery. of (context)] within the build method.
/// Or use context-dependent methods to obtain screen parameters and adaptions.
class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    /// 如果使用依赖不context方法获取屏幕参数及适配，需要调用此方法。
    /// If you use a dependent context-free method to obtain screen parameters and adaptions, you need to call this method.
    MediaQuery.of(context);

    double statusBar = ScreenUtil.getInstance().statusBarHeight;
    double width = ScreenUtil.getInstance().screenWidth;
    double height = ScreenUtil.getInstance().screenHeight;
    double density = ScreenUtil.getInstance().screenDensity;
    double sp = ScreenUtil.getInstance().getSp(24);
    double spc = ScreenUtil.getScaleSp(context, 24);
    print(
        "MainPage statusBar: $statusBar, width: $width, height: $height, density: $density, sp: $sp, spc: $spc");

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
            onPressed: () {
              Navigator.push(
                  context,
                  new CupertinoPageRoute<void>(
                      builder: (ctx) => new SecondPage()));
            },
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
                "未适配宽",
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
                "已适配宽",
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
            height: ScreenUtil.getInstance().getWidth(100.0),
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
      drawer: new MyDrawer(),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double statusBar = ScreenUtil.getInstance().statusBarHeight;
    double width = ScreenUtil.getInstance().screenWidth;
    double height = ScreenUtil.getInstance().screenHeight;
    print("SecondPage statusBar: $statusBar, width: $width, height: $height");

    return new Container(
      color: Colors.white,
      width: ScreenUtil.getInstance().getWidth(240),
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new Container(
            color: Colors.teal,
            padding:
                EdgeInsets.only(top: ScreenUtil.getInstance().statusBarHeight),
            child: new Center(
              child: new Text(
                "Sky24n",
                style: new TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            height: 160,
          )
        ],
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SecondPageState();
  }
}

class SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();
    _init();
    _initWithCtx();
  }

  void _init() {
    double screenWidth = ScreenUtil.getInstance().screenWidth;
    double screenHeight = ScreenUtil.getInstance().screenHeight;
    double screenDensity = ScreenUtil.getInstance().screenDensity;
    double statusBarHeight = ScreenUtil.getInstance().statusBarHeight;
    double bottomBarHeight = ScreenUtil.getInstance().bottomBarHeight;
    double appBarHeight = ScreenUtil.getInstance().appBarHeight;
    double adapterW100 = ScreenUtil.getInstance().getWidth(100);
    double adapterH100 = ScreenUtil.getInstance().getHeight(100);
    double adapterSp100 = ScreenUtil.getInstance().getSp(100);
    double adapterW100px = ScreenUtil.getInstance().getWidthPx(300);
    double adapterH100px = ScreenUtil.getInstance().getHeightPx(300);

    print("SecondPage _init screenWidth: $screenWidth, screenHeight: $screenHeight, screenDensity: $screenDensity" +
        ", statusBarHeight: $statusBarHeight, bottomBarHeight: $bottomBarHeight, appBarHeight: $appBarHeight" +
        ", adapterW100: $adapterW100, adapterH100: $adapterH100, adapterSp100: $adapterSp100" +
        ", adapterW100px: $adapterW100px, adapterH100px: $adapterH100px");
  }

  void _initWithCtx() {
    double screenWidth = ScreenUtil.getScreenW(context);
    double screenHeight = ScreenUtil.getScreenH(context);
    double screenDensity = ScreenUtil.getScreenDensity(context);
    double statusBarHeight = ScreenUtil.getStatusBarH(context);
    double bottomBarHeight = ScreenUtil.getBottomBarH(context);
    double adapterW100 = ScreenUtil.getScaleW(context, 100);
    double adapterH100 = ScreenUtil.getScaleH(context, 100);
    double adapterSp100 = ScreenUtil.getScaleSp(context, 100);
    Orientation orientation = ScreenUtil.getOrientation(context);

    print("SecondPage _initWithCtx screenWidth: $screenWidth, screenHeight: $screenHeight, screenDensity: $screenDensity" +
        ", statusBarHeight: $statusBarHeight, bottomBarHeight: $bottomBarHeight" +
        ", adapterW100: $adapterW100, adapterH100: $adapterH100, adapterSp100: $adapterSp100");
  }

  @override
  Widget build(BuildContext context) {
    double statusBar = ScreenUtil.getInstance().statusBarHeight;
    double width = ScreenUtil.getInstance().screenWidth;
    double height = ScreenUtil.getInstance().screenHeight;
    print("SecondPage statusBar: $statusBar, width: $width, height: $height");

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Second Page"),
        centerTitle: true,
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
            height: ScreenUtil.getInstance().getWidth(100.0),
            color: Colors.grey,
            child: new Center(
              child: new Text(
                "你好你好你好",
                style: new TextStyle(
                    fontSize: ScreenUtil.getInstance().getSp(24.0)),
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            width: ScreenUtil.getScaleW(context, 100.0),
            height: ScreenUtil.getScaleW(context, 100.0),
            color: Colors.grey,
            child: new Center(
              child: new Text(
                "你好你好你好",
                style: new TextStyle(
                    fontSize: ScreenUtil.getScaleSp(context, 24.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
