import 'dart:async';

import 'package:flutter/services.dart';

class Flustars {
  static const MethodChannel _channel =
  const MethodChannel('flustars');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
