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
  static SharedPreferences _SP;
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
    _SP = await SharedPreferences.getInstance();
  }

  static String getString(String key) {
    if (_SP == null) return null;
    return _SP.getString(key);
  }

  static Future<bool> putString(String key, String value) {
    if (_SP == null) return null;
    return _SP.setString(key, value);
  }

  static bool getBool(String key) {
    if (_SP == null) return null;
    return _SP.getBool(key);
  }

  static Future<bool> putBool(String key, bool value) {
    if (_SP == null) return null;
    return _SP.setBool(key, value);
  }

  static int getInt(String key) {
    if (_SP == null) return null;
    return _SP.getInt(key);
  }

  static Future<bool> putInt(String key, int value) {
    if (_SP == null) return null;
    return _SP.setInt(key, value);
  }

  static double getDouble(String key) {
    if (_SP == null) return null;
    return _SP.getDouble(key);
  }

  static Future<bool> putDouble(String key, double value) {
    if (_SP == null) return null;
    return _SP.setDouble(key, value);
  }

  static List<String> getStringList(String key) {
    return _SP.getStringList(key);
  }

  static Future<bool> putStringList(String key, List<String> value) {
    if (_SP == null) return null;
    return _SP.setStringList(key, value);
  }

  static dynamic getDynamic(String key) {
    if (_SP == null) return null;
    return _SP.get(key);
  }

  static Set<String> getKeys() {
    if (_SP == null) return null;
    return _SP.getKeys();
  }

  static Future<bool> remove(String key) {
    if (_SP == null) return null;
    return _SP.remove(key);
  }

  static Future<bool> clear() {
    if (_SP == null) return null;
    return _SP.clear();
  }
}
