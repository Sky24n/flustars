import 'package:flutter/material.dart';
import 'dart:ui' as ui show window;

/**
 * @Author: thl
 * @GitHub: https://github.com/Sky24n
 * @Email: 863764940@qq.com
 * @Description: Screen Util.
 * @Date: 2018/9/8
 */

///默认设计稿尺寸（单位 dp or pt）
double _designW = 360.0;
double _designH = 640.0;
double _designD = 3.0;

/**
 * 配置设计稿尺寸（单位 dp or pt）
 * w 宽
 * h 高
 * density 像素密度
 */
void setDesignWHD(double w, double h, {double density: 3.0}) {
  _designW = w;
  _designH = h;
  _designD = density;
}

///
class ScreenUtil {
  double _screenWidth;
  double _screenHeight;
  double _screenDensity;
  double _statusBarHeight;
  double _bottomBarHeight;
  double _appBarHeight;
  double _textScaleFactor;
  MediaQueryData _mediaQueryData;

  static final ScreenUtil _singleton = ScreenUtil._init();

  static ScreenUtil getInstance() {
    return _singleton;
  }

  factory ScreenUtil() {
    return _singleton;
  }

  ScreenUtil._init() {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    _mediaQueryData = mediaQuery;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _screenDensity = mediaQuery.devicePixelRatio;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
    _appBarHeight = kToolbarHeight;
  }

  /// screen width
  /// 屏幕 宽
  double get screenWidth => _screenWidth;

  /// screen height
  /// 屏幕 高
  double get screenHeight => _screenHeight;

  /// appBar height
  /// appBar 高
  double get appBarHeight => _appBarHeight;

  /// screen density
  /// 屏幕 像素密度
  double get screenDensity => _screenDensity;

  /// status bar Height
  /// 状态栏高度
  double get statusBarHeight => _statusBarHeight;

  /// bottom bar Height
  double get bottomBarHeight => _bottomBarHeight;

  /// media Query Data
  MediaQueryData get mediaQueryData => _mediaQueryData;

  /// screen width
  /// 当前屏幕 宽
  static double getScreenWidth(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width;
  }

  /// screen height
  /// 当前屏幕 高
  static double getScreenHeight(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height;
  }

  /// Orientation
  /// 设备方向(portrait, landscape)
  static Orientation getOrientation(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation;
  }

  /// 返回根据屏幕宽适配后尺寸（单位 dp or pt）
  /// size 单位 dp or pt
  double getWidth(double size) {
    return size * _screenWidth / _designW;
  }

  /// 返回根据屏幕高适配后尺寸 （单位 dp or pt）
  /// size 单位 dp or pt
  double getHeight(double size) {
    return size * _screenHeight / _designH;
  }

  /// 返回根据屏幕宽适配后尺寸（单位 dp or pt）
  /// sizePx 单位px
  double getWidthPx(double sizePx) {
    return sizePx * _screenWidth / (_designW * _designD);
  }

  /// 返回根据屏幕高适配后尺寸（单位 dp or pt）
  /// sizePx 单位px
  double getHeightPx(double sizePx) {
    return sizePx * _screenHeight / (_designH * _designD);
  }

  /// 返回根据屏幕宽适配后字体尺寸
  /// fontSize 字体尺寸
  /// sySystem 是否跟随系统字体大小设置，默认 true。
  double getSp(double fontSize, {bool sySystem: true}) {
    return (sySystem ? _textScaleFactor : 1.0) *
        fontSize *
        _screenWidth /
        _designW;
  }
}
