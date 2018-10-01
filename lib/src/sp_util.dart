import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  static SpUtil singleton = new SpUtil();
  static SharedPreferences _sharedPreferences;

  static SpUtil getInstance() {
    return singleton;
  }

  void init() {}
}
