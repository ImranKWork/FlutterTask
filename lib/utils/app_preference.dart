import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static put(String key, dynamic value) async {
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is List) {
      //prefs.setStringList(key, value);
    }
  }

  static getString(String key) async {
    String? value = prefs.getKeys().contains(key) ? prefs.getString(key) : "";
    return value;
  }

  getInt(String key) async {
    return prefs.getInt(key);
  }

  getDouble(String key) async {
    return prefs.getDouble(key);
  }

  getBool(String key) async {
    return prefs.getBool(key);
  }

  remove(String key) async {
    prefs.remove(key);
  }

  clear() async {
    prefs.clear();
  }
}
