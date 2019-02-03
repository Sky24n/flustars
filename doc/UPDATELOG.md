## 更新说明
#### v0.1.9(2019.01.07)   
移除DioUtil，如有需要，请到[flutter_wanandroid][flutter_wanandroid_github]该项目中copy。

#### v0.1.8(2018.12.29)   
ScreenUtil 屏幕适配更新。  
方案一、不依赖context
```
步骤 1
//如果设计稿尺寸默认配置一致，无需该设置。  配置设计稿尺寸 默认 360.0 / 640.0 / 3.0
setDesignWHD(_designW,_designH,_designD);  
  
步骤 2
// 在MainPageState build 调用MediaQuery.of(context)
class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
  
    // 在 MainPageState build 调用 MediaQuery.of(context)
    MediaQuery.of(context);
    
    double width = ScreenUtil.getInstance().screenWidth;
    double height = ScreenUtil.getInstance().screenHeight;
    return new Scaffold(
      appBar: new AppBar(),
    );
  }
}  
  
步骤 3
ScreenUtil.getInstance().screenWidth
ScreenUtil.getInstance().screenHeight
ScreenUtil.getInstance().screenDensity
ScreenUtil.getInstance().statusBarHeight
ScreenUtil.getInstance().bottomBarHeight
//屏幕适配相关  
ScreenUtil.getInstance().getWidth(size); //返回根据屏幕宽适配后尺寸（单位 dp or pt）
ScreenUtil.getInstance().getHeight(size); //返回根据屏幕高适配后尺寸 （单位 dp or pt）
ScreenUtil.getInstance().getWidthPx(sizePx); //sizePx 单位px
ScreenUtil.getInstance().getHeightPx(sizePx); //sizePx 单位px
ScreenUtil.getInstance().getSp(fontSize); //返回根据屏幕宽适配后字体尺寸

```
方案二、依赖context
```
//如果设计稿尺寸默认配置一致，无需该设置。  配置设计稿尺寸 默认 360.0 / 640.0 / 3.0
setDesignWHD(_designW,_designH,_designD);  

ScreenUtil.getScreenW(context); //屏幕 宽
ScreenUtil.getScreenH(context); //屏幕 高
ScreenUtil.getScreenDensity(context); //屏幕 像素密度
ScreenUtil.getStatusBarH(context); //状态栏高度
ScreenUtil.getBottomBarH(context); //bottombar 高度
//屏幕适配相关  
ScreenUtil.getScaleW(context, size); //返回根据屏幕宽适配后尺寸（单位 dp or pt）
ScreenUtil.getScaleH(context, size); //返回根据屏幕高适配后尺寸 （单位 dp or pt）
ScreenUtil.getScaleSp(context, size) ;//返回根据屏幕宽适配后字体尺寸
```

#### v0.1.6(2018.12.20)  
新增网络请求工具DioUtil, 单例模式，可输出请求日志。详细请求+解析请参考[flutter_wanandroid][flutter_wanandroid_github]项目。
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

#### v0.1.5(2018.12.14)  
ScreenUtil 新增屏幕适配。
```
//如果设计稿尺寸默认配置一致，无需该设置。  配置设计稿尺寸 默认 360.0 / 640.0 / 3.0
setDesignWHD(_designW,_designH,_designD);

//返回根据屏幕宽适配后尺寸（单位 dp or pt）
ScreenUtil.getInstance().getWidth(100.0);  

//返回根据屏幕高适配后尺寸（单位 dp or pt）
ScreenUtil.getInstance().getHeight(100.0); 

//返回根据屏幕宽适配后字体尺寸
ScreenUtil.getInstance().getSp(12.0); 
```
v0.1.4(2018.11.22)  
ScreenUtil不依赖context获取屏幕数据。  

新增MyAppBar,不需要GlobalKey就能openDrawer。  


[flutter_wanandroid_github]: https://github.com/Sky24n/flutter_wanandroid
