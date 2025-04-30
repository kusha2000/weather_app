import 'package:shared_preferences/shared_preferences.dart';

class ThemePersistance {
  //store the user's saved theme in shared preferences
  Future<void> storeTheme(bool isDark) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool("isDark", isDark);
    print("Theme Stored");
  }

  //Load the user's saved theme from shared preferences
  Future<bool> loadTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("Theme loaded");
    return preferences.getBool("isDark") ?? false;
  }
}
