import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  static const keyName = 'name';
  static const keyImage = 'image';
  static Future<SharedPreferences> get _instance async {
    return await SharedPreferences.getInstance();
  }

   Future saveString(String key, String image) async {
    try {
      final prefs = await _instance;
      await prefs.setString(keyName, key);
      await prefs.setString(keyImage, image);
      return true;
      } on Exception catch (_) {
        return false;
      }
  }

  Future<String?> getString(String key) async {
    final prefs = await _instance;
    return prefs.getString(key) ?? '';
  }

  Future<void> remove(String key) async {
    final prefs = await _instance;
    await prefs.remove(key);
  }

  Future<Map<String, String>> getSettings() async {
  final prefs = await _instance;
  final String name = prefs.getString(keyName) ?? '';
  final String image =  prefs.getString(keyImage) ?? '';
  try {
  return {
    keyName: name,
    keyImage: image
  };
  } on Exception catch (e) {
    print('Error retrieving settings: $e');
    return {};
  }
  }
}