import 'package:flutter/material.dart';
import 'package:weather_app/services/theme_persistance.dart';
import 'package:weather_app/utils/thems.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _loadTheme();
  }
  ThemeData _themeData = ThemeDataModes.lightTheme;

  final ThemePersistance _themePersistance = ThemePersistance();

  //getter
  ThemeData get getThemeData => _themeData;

  //setter
  set setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  //load the theme from shared pref
  Future<void> _loadTheme() async {
    bool isDark = await _themePersistance.loadTheme();
    setThemeData =
        isDark ? ThemeDataModes.darkTheme : ThemeDataModes.lightTheme;
  }

  //toggle theme
  Future<void> toggleTheme(bool isDark) async {
    setThemeData =
        isDark ? ThemeDataModes.darkTheme : ThemeDataModes.lightTheme;

    await _themePersistance.storeTheme(isDark);
    notifyListeners();
  }
}
