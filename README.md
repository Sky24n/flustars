Language: [English](README-EN.md) | 中文简体

[![Pub](https://img.shields.io/pub/v/flustars.svg?style=flat-square&color=009688)](https://pub.dartlang.org/packages/flustars)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Pub](https://img.shields.io/pub/v/flustars.svg?style=flat-square&color=2196F3)](https://pub.flutter-io.cn/packages/flustars)

# Flutter常用工具类库

flustars依赖于Dart常用工具类库[common_utils](https://github.com/Sky24n/common_utils),以及对其他第三方库封装，致力于为大家分享简单易用工具类。如果你有好的工具类欢迎PR.  
目前包含SharedPreferences Util, Screen Util, Directory Util, Widget Util, Image Util。

[✓] Flutter (Channel stable, v2.0.0, locale zh-Hans-CN)

### Pub
```yaml
dependencies:
  flustars: ^2.0.1
  
  # https://github.com/Sky24n/sp_util
  # sp_util分拆成单独的库，可以直接引用
  sp_util: ^2.0.3
```

### [Change Log](CHANGE_LOG.md)
v2.0.0  
Migrate to null-safety.

v0.3.3  
分拆[sp_util](https://github.com/Sky24n/sp_util)成单独的库，可以直接引用

[common_utils](https://github.com/Sky24n/common_utils)新版本v1.2.0。  
如果项目中使用了 flustars: ^0.2.6及以上版本。  
删除pubspec.lock文件，直接运行flutter  packages get 即可使用最新版！  
  
common_utils v1.2.0  
1、新增JsonUtil。  
2、新增EncryptUtil 简单加解密。  
3、LogUtil 更新。
```yaml
String objStr = "{\"name\":\"成都市\"}";
City hisCity = JsonUtil.getObj(objStr, (v) => City.fromJson(v));
String listStr = "[{\"name\":\"成都市\"}, {\"name\":\"北京市\"}]";
List<City> cityList = JsonUtil.getObjList(listStr, (v) => City.fromJson(v));

const String key = '11, 22, 33, 44, 55, 66';
String value = 'Sky24n';
String encode = EncryptUtil.xorBase64Encode(value, key); // WH1YHgMs
String decode = EncryptUtil.xorBase64Decode(encode, key); // Sky24n

//超长log查看
common_utils e  — — — — — — — — — — — — — — — — st — — — — — — — — — — — — — — — —
common_utils e | 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,
common_utils e | 7,988,989,990,991,992,993,994,995,996,997,998,999,
common_utils e  — — — — — — — — — — — — — — — — ed — — — — — — — — — — — — — — — —
```

### [Flutter工具类库 flustars][flustars_github]
 1、SpUtil       : 单例"同步"SharedPreferences工具类。支持get传入默认值，支持存储对象，支持存储对象数组。  
 2、ScreenUtil   : 屏幕适配，获取屏幕宽、高、密度，AppBar高，状态栏高度，屏幕方向.  
 3、WidgetUtil   : 监听Widget渲染状态，获取Widget宽高，在屏幕上的坐标，获取网络/本地图片尺寸.  
 4、DioUtil      : 单例Dio网络工具类(已迁移至此处[DioUtil](https://github.com/Sky24n/flutter_wanandroid/blob/master/lib/data/net/dio_util.dart))。  
 5、ImageUtil    : 获取网络/本地图片尺寸.

### [Dart常用工具类库 common_utils][common_utils_github]  
 1、TimelineUtil : 时间轴.(新)  
 2、TimerUtil    : 倒计时，定时任务.(新)  
 3、MoneyUtil    : 精确转换，元转分，分转元，支持格式输出.(新)  
 4、LogUtil      : 简单封装打印日志.(新)  
 5、DateUtil     : 日期转换格式化输出.  
 6、RegexUtil    : 正则验证手机号，身份证，邮箱等等.  
 7、NumUtil      : 保留x位小数, 精确加、减、乘、除, 防止精度丢失.  
 8、ObjectUtil   : 判断对象是否为空(String List Map),判断两个List是否相等.  
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
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(MyApp());
}

class MyAppState extends State<MyApp> {
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
    return MaterialApp();
  }
}

```

* #### ScreenUtil -> [Example](./example/lib/main.dart) 
```
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
```
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
```
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
```
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

### 关于作者
GitHub &nbsp;&nbsp;&nbsp;: [Sky24n](https://github.com/Sky24n)  
简书 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: [Sky24n](https://www.jianshu.com/u/cbf2ad25d33a)  
掘金 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: [Sky24n](https://juejin.im/user/5b9e8a92e51d453df0440422/posts)  
项目合集 : [FlutterRepos](https://github.com/Sky24n/FlutterRepos)

### Changelog
Please see the [Changelog](CHANGELOG.md) page to know what's recently changed.

### Apps
[flutter_wanandroid](https://github.com/Sky24n/flutter_wanandroid)  
[Moss](https://github.com/Sky24n/Moss).  
A GitHub client app developed with Flutter, which supports Android iOS Web.  
Web ：[Flutter Web](https://sky24n.github.io/Sky24n/moss/web/index.html).

|![](https://z3.ax1x.com/2021/04/26/gp1hm6.jpg)|![](https://z3.ax1x.com/2021/04/26/gp1Tte.jpg)|![](https://z3.ax1x.com/2021/04/26/gp17fH.jpg)|
|:---:|:---:|:---:|



[flutter_wanandroid_github]: https://github.com/Sky24n/flutter_wanandroid

[common_utils_github]: https://github.com/Sky24n/common_utils

[flustars_github]: https://github.com/Sky24n/flustars
