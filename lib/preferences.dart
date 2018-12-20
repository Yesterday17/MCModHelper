import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences _prefs;
  static Preferences instance = Preferences();

  SharedPreferences get prefs => _prefs;

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }
}
