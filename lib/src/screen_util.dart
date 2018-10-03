import 'package:flutter/material.dart';

/**
 * @Author: thl
 * @GitHub: https://github.com/Sky24n
 * @Description: Screen Util.
 * @Date: 2018/9/8
 */

///
class ScreenUtil {
  static double _screenWidth;
  static double _screenHeight;
  static double _screenDensity;
  static double _statusBarHeight;
  static double _appBarHeight;
  static MediaQueryData _mediaQueryData;

  static ScreenUtil singleton = new ScreenUtil();

  static ScreenUtil getInstance() {
    return singleton;
  }

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _screenDensity = mediaQuery.devicePixelRatio;
    _statusBarHeight = mediaQuery.padding.top;
    _appBarHeight = kToolbarHeight;
  }

  ///screen width
  static double get screenWidth => _screenWidth;

  ///screen height
  static double get screenHeight => _screenHeight;

  ///appBar height
  static double get appBarHeight => _appBarHeight;

  ///screen density
  static double get screenDensity => _screenDensity;

  ///status bar Height
  static double get statusBarHeight => _statusBarHeight;

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  static double getScreenWidth(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width;
  }

  static double getScreenHeight(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height;
  }

  static Orientation getOrientation(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation;
  }
}
