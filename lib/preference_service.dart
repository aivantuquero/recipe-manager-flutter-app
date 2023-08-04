import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static late SharedPreferences _sharedPreferencesInstance;

  static Future<void> init() async {
    _sharedPreferencesInstance = await SharedPreferences.getInstance();
  }

  static SharedPreferences get sharedPreferencesInstance => _sharedPreferencesInstance;
}
