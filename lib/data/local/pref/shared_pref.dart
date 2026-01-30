import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref? _instance;
  static SharedPreferences? _preferences;

  SharedPref._();

  static Future<SharedPref> get instance async {
    if (_instance == null) {
      _instance = SharedPref._();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // String operations
  Future<bool> setString(String key, String value) async {
    return await _preferences!.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return _preferences!.getString(key);
  }

  // Bool operations
  Future<bool> setBool(String key, bool value) async {
    return await _preferences!.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return _preferences!.getBool(key);
  }

  // Int operations
  Future<bool> setInt(String key, int value) async {
    return await _preferences!.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    return _preferences!.getInt(key);
  }

  // Double operations
  Future<bool> setDouble(String key, double value) async {
    return await _preferences!.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    return _preferences!.getDouble(key);
  }

  // List<String> operations
  Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences!.setStringList(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    return _preferences!.getStringList(key);
  }

  // Remove
  Future<bool> remove(String key) async {
    return await _preferences!.remove(key);
  }

  // Clear all
  Future<bool> clear() async {
    return await _preferences!.clear();
  }

  // Contains
  Future<bool> containsKey(String key) async {
    return _preferences!.containsKey(key);
  }
}
