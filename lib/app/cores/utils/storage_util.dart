import 'dart:async';

import 'package:get_storage/get_storage.dart';

class StorageUtil {
  static final storage = GetStorage();

  static Future<void> setDataAsync({
    required String key,
    required String value,
  }) async {
    await storage.write(key, value);
  }

  static void setData({
    required String key,
    required String value,
  }) {
    storage.write(key, value);
  }

  static int getInt(String key, {int defaultValue = -1}) =>
      storage.read(key) ?? defaultValue;

  static String getString(String key, {String defaultValue = ''}) =>
      storage.read(key) ?? defaultValue;

  static bool getBool(String key, {bool defaultValue = false}) =>
      storage.read(key) ?? defaultValue;

  static double getDouble(String key, {double defaultValue = 0.0}) =>
      storage.read(key) ?? defaultValue;

  static dynamic getData(String key) => storage.read(key);

  static Future<void> clearData() async => storage.erase();
}
