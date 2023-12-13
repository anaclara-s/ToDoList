import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  static const myList = 'my_list';
  static SharedPreferences? _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> putStringList(List<String> value) async {
    if (_prefs != null) {
      await _prefs!.setStringList(myList, value);
    }
  }

  static List<String> getListString() {
    return _prefs == null
        ? List.empty()
        : _prefs!.getStringList(myList) ?? List.empty();
  }
}
