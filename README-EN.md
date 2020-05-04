Language: English | [中文简体](https://github.com/Sky24n/flustars)

# flustars(Flutter common utils library)
[![Pub](https://img.shields.io/pub/v/flustars.svg?style=flat-square)](https://pub.dartlang.org/packages/flustars)  

Flutter common utils library, SharedPreferences Util, Screen Util, Directory Util, Widget Util, Image Util。If you have good tools, welcome PR.

Pub [flustars](https://pub.flutter-io.cn/packages/flustars)

[✓] Flutter (Channel stable, v1.12.13+hotfix.9, locale zh-Hans-CN)

## Get started

### Add dependency
```yaml
dependencies:
  flustars: ^0.3.1
  
import 'package:flustars/flustars.dart';

or

// git (version 0.3.1)
dependencies:
  flustars:
    git:
      url: git://github.com/Sky24n/flustars.git
```

### [Change Log](CHANGE_LOG.md)

v0.3.0
add ImageUtil。

### Flutter common util library [flustars][flustars_github]
 1、SpUtil       : SharedPreferences util, support save object, object list.  
 2、ScreenUtil   : adapter size，screen size.  
 3、WidgetUtil   : Widget rendering listener，get Widget Bounds.  
 4、DioUtil      : dio util move to [DioUtil](https://github.com/Sky24n/FlutterRepos/blob/master/base_library/lib/src/data/net/dio_util.dart)。  
 5、ImageUtil    : get image size.

### Dart common util library [common_utils][common_utils_github]
 1、TimelineUtil : timeline util.  
 2、TimerUtil    : timer util.  
 3、MoneyUtil    : money util.  
 4、LogUtil      : log util.  
 5、DateUtil     : date util.  
 6、RegexUtil    : regex util, mobile, email, date.
 7、NumUtil      : num util.  
 8、ObjectUtil   : object util.
 9、TextUtil     : TextUtil.  
 10、EncryptUtil : EncryptUtil.  
 11、JsonUtil    : JsonUtil.


### APIs

* #### SpUtil -> [Example](./example/lib/main.dart)
```dart
getObj
getObjList
putObject
getObject
putObjectList
getObjectList
getString
putString
getBool
putBool
getInt
putInt
getDouble
putDouble
getStringList
putStringList
getDynamic
haveKey
getKeys
remove
clear
isInitialized
  
  
/// SpUtil使用：
/// 方式一
/// 等待sp初始化完成后再运行app。
/// sp初始化时间 release模式下30ms左右，debug模式下100多ms。
void main() async {
  await SpUtil.getInstance();
  runApp(MyApp());
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    /// 同步使用Sp。
    SpUtil.remove("username");
    String defName = SpUtil.getString("username", defValue: "sky");
    SpUtil.putString("username", "sky24");
    String name = SpUtil.getString("username");
    print("MyApp defName: $defName, name: $name");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
    );
  }
}  


/// 方式二
/// 增加闪屏页，在闪屏页SpUtil初始化完成， await SpUtil.getInstance();
/// 跳转到主页后，可以直接同步使用。 String defName = SpUtil.getString("username");
   
import 'package:flustars/flustars.dart'; 
  
/// SpUtil详细使用示例！  
void main() => runApp(MyApp());
  
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}
  
class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initAsync();
  }
  
  _initAsync() async {
    /// App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();

    /// 同步使用Sp。
    SpUtil.remove("username");
    String defName = SpUtil.getString("username", defValue: "sky");
    SpUtil.putString("username", "sky24");
    String name = SpUtil.getString("username");
    print("MyApp defName: $defName, name: $name");
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/MainPage': (ctx) => MyHomePage(),
      },
      home: SplashPage(),
    );
  }
}  
  
/// 闪屏页。
class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);
  
  @override
  _SplashPageState createState() => _SplashPageState();
}
  
class _SplashPageState extends State<SplashPage> {
  String _info = '';
  
  @override
  void initState() {
    super.initState();
    _initAsync();
  }
  
  _initAsync() async {
    /// App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();
    Future.delayed(new Duration(milliseconds: 500), () {
      /// 同步使用Sp。
      /// 是否显示引导页。
      if (SpUtil.getBool("key_guide", defValue: true)) {
        SpUtil.putBool("key_guide", false);
        _initBanner();
      } else {
        _initSplash();
      }
    });
  }
  
  /// App引导页逻辑。
  void _initBanner() {
    setState(() {
      _info = "引导页～";
    });
  }
  
  /// App广告页逻辑。
  void _initSplash() {
    setState(() {
      _info = "广告页，2秒后跳转到主页";
    });
    Future.delayed(new Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacementNamed('/MainPage');
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash"),
      ),
      body: new Center(
        child: new Text("$_info"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool isGuide = SpUtil.getBool("key_guide", defValue: true);
          if (isGuide) {
            Navigator.of(context).pushReplacementNamed('/MainPage');
          }
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
  
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
  
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    
    /// 同步使用Sp。
   
    /// 存取基础类型
    SpUtil.putString("username", "Sky24n");
    String userName = SpUtil.getString("username");
    print("MyHomePage userName: " + userName);
    
    bool isFirst = SpUtil.getBool("userName", defValue: true);
    SpUtil.putBool("isFirst", false);
    print("MyHomePage isFirst: $isFirst");
    
    /// save object example.
    /// 存储实体对象示例。
    City city = new City();
    city.name = "成都市";
    SpUtil.putObject("loc_city", city);
    
    City hisCity = SpUtil.getObj("loc_city", (v) => City.fromJson(v));
    print("City: " + (hisCity == null ? "null" : hisCity.toString()));
    
    /// save object list example.
    /// 存储实体对象list示例。
    List<City> list = new List();
    list.add(new City(name: "成都市"));
    list.add(new City(name: "北京市"));
    SpUtil.putObjectList("loc_city_list", list);
    
    List<City> _cityList = SpUtil.getObjList("loc_city_list", (v) => City.fromJson(v));
    print("City list: " + (_cityList == null ? "null" : _cityList.toString()));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: new Center(
        child: new Text(SpUtil.getString("username")),
      ),
    );
  }
}
  
class City {
  String name;
  
  City({this.name});
  
  /// 必须写.
  City.fromJson(Map<String, dynamic> json) : name = json['name'];
  
  /// 必须写.
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

```

* #### ScreenUtil -> [Example](./example/lib/main.dart) 
```dart
getWidth                  : 返回根据屏幕宽适配后尺寸.
getHeight                 : 返回根据屏幕高适配后尺寸.
getWidthPx                : 返回根据屏幕宽适配后尺寸.
getHeightPx               : 返回根据屏幕高适配后尺寸.
getSp                     : 返回根据屏幕宽适配后字体尺寸.
screenWidth               : 获取屏幕宽.
screenHeight              : 获取屏幕高.
screenDensity             : 获取屏幕密度.
appBarHeight              : 获取系统AppBar高度.
statusBarHeight           : 获取系统状态栏高度.
getScreenW(ctx)           : 当前屏幕 宽.
getScreenH(ctx)           : 当前屏幕 高.
getStatusBarH(ctx)        : 当前状态栏高度.
getBottomBarH(ctx)        : 当前BottomBar高度.
getScaleW(ctx,size)       : 返回根据屏幕宽适配后尺寸.
getScaleH(ctx,size)       : 返回根据屏幕高适配后尺寸.
getScaleSp(ctx,size)      : 返回根据屏幕宽适配后字体尺寸.  
getScaleSp(ctx,size)      : 返回根据屏幕宽适配后字体尺寸.  

///旧适配方法仅适用于纵屏适配。
///推荐使用以下新适配方法。
getAdapterSize(size)             : 返回适配后尺寸，可用于宽，高，字体尺寸.  
getAdapterSizeCtx(ctx,size)      : 返回适配后尺寸，可用于宽，高，字体尺寸.   

double adapterSize = ScreenUtil.getInstance().getAdapterSize(100);
double adapterSize = ScreenUtil.getAdapterSizeCtx(context, 100);
  
一、不依赖context
// 屏幕宽
double screenWidth = ScreenUtil.getInstance().screenWidth;
// 屏幕高
double screenHeight = ScreenUtil.getInstance().screenHeight;
// 屏幕像素密度
double screenDensity = ScreenUtil.getInstance().screenDensity;
// 系统状态栏高度
double statusBarHeight = ScreenUtil.getInstance().statusBarHeight;
// BottomBar高度 
double bottomBarHeight = ScreenUtil.getInstance().bottomBarHeight;
// 系统AppBar高度
double appBarHeight = ScreenUtil.getInstance().appBarHeight;
// 根据屏幕宽适配后尺寸
double adapterW100 = ScreenUtil.getInstance().getWidth(100);
// 根据屏幕高适配后尺寸
double adapterH100 = ScreenUtil.getInstance().getHeight(100);
// 根据屏幕宽适配后字体尺寸
double adapterSp100 = ScreenUtil.getInstance().getSp(100);
// 根据屏幕宽适配后尺寸(输入px)
double adapterW100px = ScreenUtil.getInstance().getWidthPx(300);
// 根据屏幕高适配后尺寸(输入px)
double adapterH100px = ScreenUtil.getInstance().getHeightPx(300);
  
二、依赖context
// 屏幕宽
double screenWidth = ScreenUtil.getScreenW(context);
// 屏幕高
double screenHeight = ScreenUtil.getScreenH(context);
// 屏幕像素密度
double screenDensity = ScreenUtil.getScreenDensity(context);
// 系统状态栏高度
double statusBarHeight = ScreenUtil.getStatusBarH(context);
// BottomBar高度
double bottomBarHeight = ScreenUtil.getBottomBarH(context);
// 根据屏幕宽适配后尺寸
double adapterW100 = ScreenUtil.getScaleW(context, 100);
// 根据屏幕高适配后尺寸
double adapterH100 = ScreenUtil.getScaleH(context, 100);
// 根据屏幕宽适配后字体尺寸
double adapterSp100 = ScreenUtil.getScaleSp(context, 100);
// 屏幕方向
Orientation orientation = ScreenUtil.getOrientation(context);

```

* #### DirectoryUtil
```dart
setInitDir
initTempDir
initAppDocDir
initAppSupportDir
initStorageDir
createDirSync
createDir
getTempPath
getAppDocPath
getAppSupportPath
getStoragePath
createTempDirSync
createAppDocDirSync
createStorageDirSync
createTempDir
createAppDocDir
createStorageDir

    await DirectoryUtil.getInstance();
    String tempPath = DirectoryUtil.getTempPath(
        category: 'Pictures', fileName: 'demo', format: 'png');
    print("thll  tempPath: $tempPath");

    String appDocPath = DirectoryUtil.getAppDocPath(
        category: 'Pictures', fileName: 'demo', format: 'png');
    print("thll  appDocPath: $appDocPath");

    String appSupportPath = DirectoryUtil.getAppSupportPath(
        category: 'Pictures', fileName: 'demo', format: 'png');
    print("thll  appSupportPath: $appSupportPath");

    String storagePath = DirectoryUtil.getStoragePath(
        category: 'Pictures', fileName: 'demo', format: 'png');
    print("thll  storagePath: $storagePath");

```

* #### WidgetUtil -> [Example1](https://github.com/Sky24n/flutter_wanandroid/blob/master/lib/demos/widget_page.dart)，[Example2](https://github.com/Sky24n/flutter_wanandroid/blob/master/lib/demos/image_size_page.dart)
```dart
asyncPrepare              : Widget渲染监听，监听widget宽高变化,callback返回宽高等参数.
getWidgetBounds           : 获取widget 宽高.
getWidgetLocalToGlobal    : 获取widget在屏幕上的坐标.
getImageWH                : 获取图片宽高，加载错误情况返回 Rect.zero.（单位 px）. 
getImageWHE               : 获取图片宽高，加载错误会抛出异常.（单位 px）. 

/// widget渲染监听。
WidgetUtil widgetUtil = new WidgetUtil();
widgetUtil.asyncPrepare(context, true, (Rect rect) {
  // widget渲染完成。
});

/// widget宽高。
Rect rect = WidgetUtil.getWidgetBounds(context);

/// widget在屏幕上的坐标。
Offset offset = WidgetUtil.getWidgetLocalToGlobal(context);
  
/// 获取CachedNetworkImage下的图片尺寸
Image image = new Image(image: new CachedNetworkImageProvider("Url"));
Rect rect1 = await WidgetUtil.getImageWH(image: image);  

/// 其他image
Image imageAsset = new Image.asset("");
Image imageFile = new Image.file(File("path"));
Image imageNetwork = new Image.network("url");
Image imageMemory = new Image.memory(null);

/// 获取网络图片尺寸
Rect rect2 = await WidgetUtil.getImageWH(url: "Url");

/// 获取本地图片尺寸 localUrl 需要全路径
Rect rect3 = await WidgetUtil.getImageWH(localUrl: "assets/images/3.0x/ali_connors.png");

/// 其他方式
WidgetUtil.getImageWH(url: "Url").then((Rect rect) {
  print("rect: " + rect.toString();
});

WidgetUtil.getImageWHE(url: "Url").then((Rect rect) {
  print("rect: " + rect.toString();
}).catchError((error) {
  print("rect: " + error.toString();
});
```

* #### ImageUtil
```dart
getImageWH
```

* #### DioUtil (dio: ^1.0.13) 详细请求+解析请参考[flutter_wanandroid][flutter_wanandroid_github]项目。
```dart
// 打开debug模式.
DioUtil.openDebug(); 

// 配置网络参数.
Options options = DioUtil.getDefOptions();
options.baseUrl = "http://www.wanandroid.com/";
HttpConfig config = new HttpConfig(options: options);
DioUtil().setConfig(config);
  
// 两种单例请求方式.
DioUtil().request<List>(Method.get, "banner/json");
DioUtil.getInstance().request(Method.get, "banner/json");
  
//示例
LoginReq req = new LoginReq('username', 'password');
DioUtil().request(Method.post, "user/login",data: req.toJson());
  
//示例
FormData formData = new FormData.from({
      "username": "username",
      "password": "password",
    });
DioUtil().requestR(Method.post, "user/login",data: rformData);
  
// 网络请求日志  
I/flutter ( 5922): ----------------Http Log----------------
I/flutter ( 5922): [statusCode]:   200
I/flutter ( 5922): [request   ]:   method: GET  baseUrl: http://www.wanandroid.com/  path: lg/collect/list/0/json
I/flutter ( 5922): [reqdata   ]:   null
I/flutter ( 5922): [response  ]:   {data: {curPage: 1, datas: [], offset: 0, over: true, pageCount: 0, size: 20, total: 0}, errorCode: 0, errorMsg: }
```

### [Flutter Demos](https://github.com/Sky24n/flutter_wanandroid/tree/master/lib/demos)   
 
>- |--demos
>    - |-- city_select_page.dart 城市列表(索引&悬停)示例
>    - |-- date_page.dart 日期格式化示例
>    - |-- image_size_page.dart 获取网络/本地图片尺寸示例
>    - |-- money_page.dart 金额(元转分/分转元)示例
>    - |-- pinyin_page.dart 汉字转拼音示例
>    - |-- regex_page.dart 正则工具类示例
>    - |-- round_portrait_page.dart 圆形圆角头像示例
>    - |-- timeline_page.dart 时间轴示例
>    - |-- timer_page.dart 倒计时/定时任务示例
>    - |-- widget_page.dart 获取Widget尺寸/屏幕坐标示例

## 点击下载APK : [v0.1.x][flutter_wanandroid_apk] 
## 扫码下载APK :
  ![flutter_wanandroid][flutter_wanandroid_qr] 

### Screenshots
<img src="https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_demos/Screenshot_20181003-234414.jpg" width="200">   <img src="https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_demos/Screenshot_20181003-211011.jpg" width="200">   <img src="https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_demos/Screenshot_20180930-012302.jpg" width="200">  
<img src="https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_demos/Screenshot_20180930-012431.jpg" width="200">  <img src="https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_demos/Screenshot_20180919-231618.jpg" width="200">   <img src="https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_demos/Screenshot_20180926-144840.png" width="200">  
<img src="https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_demos/Screenshot_20180919-224204.jpg" width="200">   <img src="https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_demos/Screenshot_20180919-224146.jpg" width="200">   <img src="https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_demos/Screenshot_20180919-224231.jpg" width="200">   

### 关于作者
GitHub : [Sky24n](https://github.com/Sky24n)  
简书 &nbsp;&nbsp;&nbsp;&nbsp;: [Sky24n](https://www.jianshu.com/u/cbf2ad25d33a)  
掘金 &nbsp;&nbsp;&nbsp;&nbsp;: [Sky24n](https://juejin.im/user/5b9e8a92e51d453df0440422/posts)  
Pub &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: [Sky24n](https://pub.flutter-io.cn/packages?q=email%3Asky24no%40gmail.com)

如果您觉得本项目不错的话，来个star支持下作者吧！  
  
Flutter全局屏幕适配 [auto_size](https://github.com/flutterchina/auto_size)  
  
[![GitHub stars](https://img.shields.io/github/stars/flutterchina/auto_size.svg?style=social&label=Star)](https://github.com/flutterchina/auto_size) [![GitHub forks](https://img.shields.io/github/forks/flutterchina/auto_size.svg?style=social&label=Fork)](https://github.com/flutterchina/auto_size) [![GitHub watchers](https://img.shields.io/github/watchers/flutterchina/auto_size.svg?style=social&label=Watch)](https://github.com/flutterchina/auto_size)  
  
Flutter版玩安卓 [flutter_wanandroid](https://github.com/Sky24n/flutter_wanandroid)  
  
[![GitHub stars](https://img.shields.io/github/stars/Sky24n/flutter_wanandroid.svg?style=social&label=Star)](https://github.com/Sky24n/flutter_wanandroid) [![GitHub forks](https://img.shields.io/github/forks/Sky24n/flutter_wanandroid.svg?style=social&label=Fork)](https://github.com/Sky24n/flutter_wanandroid) [![GitHub watchers](https://img.shields.io/github/watchers/Sky24n/flutter_wanandroid.svg?style=social&label=Watch)](https://github.com/Sky24n/flutter_wanandroid)  
  
Flutter仿滴滴出行 [GreenTravel](https://github.com/Sky24n/GreenTravel)  
  
[![GitHub stars](https://img.shields.io/github/stars/Sky24n/GreenTravel.svg?style=social&label=Star)](https://github.com/Sky24n/GreenTravel) [![GitHub forks](https://img.shields.io/github/forks/Sky24n/GreenTravel.svg?style=social&label=Fork)](https://github.com/Sky24n/GreenTravel) [![GitHub watchers](https://img.shields.io/github/watchers/Sky24n/GreenTravel.svg?style=social&label=Watch)](https://github.com/Sky24n/GreenTravel)  
  
Flutter常用工具类库 [flustars](https://github.com/Sky24n/flustars)  
  
[![GitHub stars](https://img.shields.io/github/stars/Sky24n/flustars.svg?style=social&label=Star)](https://github.com/Sky24n/flustars) [![GitHub forks](https://img.shields.io/github/forks/Sky24n/flustars.svg?style=social&label=Fork)](https://github.com/Sky24n/flustars) [![GitHub watchers](https://img.shields.io/github/watchers/Sky24n/flustars.svg?style=social&label=Watch)](https://github.com/Sky24n/flustars)  
  
Dart常用工具类库 [common_utils](https://github.com/Sky24n/common_utils)  
  
[![GitHub stars](https://img.shields.io/github/stars/Sky24n/common_utils.svg?style=social&label=Star)](https://github.com/Sky24n/common_utils) [![GitHub forks](https://img.shields.io/github/forks/Sky24n/common_utils.svg?style=social&label=Fork)](https://github.com/Sky24n/common_utils) [![GitHub watchers](https://img.shields.io/github/watchers/Sky24n/common_utils.svg?style=social&label=Watch)](https://github.com/Sky24n/common_utils)  
  
Flutter城市列表 [azlistview](https://github.com/flutterchina/azlistview)  
  
[![GitHub stars](https://img.shields.io/github/stars/flutterchina/azlistview.svg?style=social&label=Star)](https://github.com/flutterchina/azlistview) [![GitHub forks](https://img.shields.io/github/forks/flutterchina/azlistview.svg?style=social&label=Fork)](https://github.com/flutterchina/azlistview) [![GitHub watchers](https://img.shields.io/github/watchers/flutterchina/azlistview.svg?style=social&label=Watch)](https://github.com/flutterchina/azlistview)  
  
Flutter汉字转拼音库 [lpinyin](https://github.com/flutterchina/lpinyin)  
  
[![GitHub stars](https://img.shields.io/github/stars/flutterchina/lpinyin.svg?style=social&label=Star)](https://github.com/flutterchina/lpinyin) [![GitHub forks](https://img.shields.io/github/forks/flutterchina/lpinyin.svg?style=social&label=Fork)](https://github.com/flutterchina/lpinyin) [![GitHub watchers](https://img.shields.io/github/watchers/flutterchina/lpinyin.svg?style=social&label=Watch)](https://github.com/flutterchina/lpinyin)  
  
Flutter国际化库 [fluintl](https://github.com/Sky24n/fluintl)  
  
[![GitHub stars](https://img.shields.io/github/stars/Sky24n/fluintl.svg?style=social&label=Star)](https://github.com/Sky24n/fluintl) [![GitHub forks](https://img.shields.io/github/forks/Sky24n/fluintl.svg?style=social&label=Fork)](https://github.com/Sky24n/fluintl) [![GitHub watchers](https://img.shields.io/github/watchers/Sky24n/fluintl.svg?style=social&label=Watch)](https://github.com/Sky24n/fluintl)  
 
[flutter_wanandroid_github]: https://github.com/Sky24n/flutter_wanandroid
[flutter_wanandroid_apk]: https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppStore/flutter_wanandroid.apk
[flutter_wanandroid_qr]: https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_wanandroid/qrcode.png

[common_utils_github]: https://github.com/Sky24n/common_utils

[flustars_github]: https://github.com/Sky24n/flustars