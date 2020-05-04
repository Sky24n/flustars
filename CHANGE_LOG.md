## [更新说明](doc/UPDATELOG.md)

v0.3.0
新增ImageUtil。

[common_utils](https://github.com/Sky24n/common_utils)新版本v1.1.3。  
如果项目中使用了 flustars: ^0.2.6及以上版本。  
删除pubspec.lock文件，直接运行flutter  packages get 即可使用最新版！

v1.1.3 (2019.07.10)  
1、新增TextUtil 银行卡号每隔4位加空格，每隔3三位加逗号，隐藏手机号等等.  
2、新增EnDecodeUtil md5加密，Base64加/解密.  
3、DateUtil 新增日期格式化，支持自定义格式输出。  
4、LogUtil 支持输出超长log。  
5、RegexUtil 支持199号段。
```dart
/// DateUtil
DateUtil.formatDateMs(DateTime.now().millisecondsSinceEpoch, format: DataFormats.full); // 2019-07-09 16:51:14
DateUtil.formatDateStr("2019-07-09 16:51:14", format: "yyyy/M/d HH:mm:ss"); // 2019/7/9 16:51:14
DateUtil.formatDate(DateTime.now(), format: "yyyy/MM/dd HH:mm:ss");  // 2019/07/09 16:51:14
  
/// TextUtil
String phoneNo = TextUtil.formatSpace4("15845678910"); // 1584 5678 910
String num     = TextUtil.formatComma3("12345678"); // 12,345,678
String phoneNo = TextUtil.hideNumber("15845678910")// 158****8910
```


v0.2.6 (2019.06.11)  
1.新增文件目录工具类
```dart
await DirectoryUtil.getInstance();
String path = DirectoryUtil.getTempPath(fileName: 'demo.png', category: 'image');
String path = DirectoryUtil.getAppDocPath(fileName: 'demo.mp4', category: 'video');
String path = DirectoryUtil.getStoragePath(fileName: 'flutterwanandroid.apk', package: 'com.thl.flutterwanandroid');

Directory dir = DirectoryUtil.createTempDirSync(package: 'doc', category: 'image');
...
```

2.SpUtil全面支持读取对象，对象列表。
```dart
City hisCity = SpUtil.getObj("loc_city", (v) => City.fromJson(v));  
List<City> _cityList = SpUtil.getObjList("loc_city_list", (v) => City.fromJson(v));
```

3.ScreenUtil 兼容横/纵屏适配。
```dart
double adapterSize = ScreenUtil.getInstance().getAdapterSize(100);
double adapterSize = ScreenUtil.getAdapterSizeCtx(context, 100)
```

v0.2.5 (2019.03.07)  
WidgetUtil 新增获取图片尺寸。  
/// get image width height，load error return Rect.zero.（unit px）  
/// 获取图片宽高，加载错误情况返回 Rect.zero.（单位 px）  
Future<Rect> getImageWH({Image image, String url, String localUrl, String package});

/// get image width height, load error throw exception.（unit px）  
/// 获取图片宽高，加载错误会抛出异常.（单位 px）  
Future<Rect> getImageWHE({Image image, String url, String localUrl, String package});
```dart
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