import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

/**
 * @Author: thl
 * @GitHub: https://github.com/Sky24n
 * @Description: Sp Util.
 * @Date: 2018/9/8
 */

///
class SpUtil {
  static SpUtil _singleton;
  static SharedPreferences _sharedPreferences;
  static Lock _lock = Lock();

  static Future<SpUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        _singleton = new SpUtil();
        await init();
      });
    }
    return _singleton;
  }

  static void init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static String getString(String key) {
    return _sharedPreferences.getString(key);
  }

  static Future<bool> putString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  static bool getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  static Future<bool> putBool(String key, bool value) {
    return _sharedPreferences.setBool(key, value);
  }

  static int getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  static Future<bool> putInt(String key, int value) {
    return _sharedPreferences.setInt(key, value);
  }

  static double getDouble(String key) {
    return _sharedPreferences.getDouble(key);
  }

  static Future<bool> putDouble(String key, double value) {
    return _sharedPreferences.setDouble(key, value);
  }

  static List<String> getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }

  static Future<bool> putStringList(String key, List<String> value) {
    return _sharedPreferences.setStringList(key, value);
  }

  static dynamic getDynamic(String key) {
    return _sharedPreferences.get(key);
  }

  static Set<String> getKeys() {
    return _sharedPreferences.getKeys();
  }

  static Future<bool> remove(String key) {
    return _sharedPreferences.remove(key);
  }

  static Future<bool> clear() {
    return _sharedPreferences.clear();
  }
}
