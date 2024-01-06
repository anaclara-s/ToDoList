import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  static const myTasksList = 'my_tasks_list';
  static const myDeletedTasksList = 'my_deleted_tasks_list';
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> putStringList(List<String> value, String key) async {
    if (_prefs != null) {
      await _prefs!.setStringList(key, value);
    }
  }

  static List<String> getListString(String key) {
    return _prefs == null
        ? List.empty()
        : _prefs!.getStringList(key) ?? List.empty();
  }
}
