import 'package:flutter/material.dart';
import 'package:habit_tracker_hive/theme/light_mode.dart';

import 'dak_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // initially light mode
  ThemeData _themeData = lightMode;

  // getter to get the current theme data
  ThemeData get themeData => _themeData;

//  is current theme dark?
  bool get isDark => _themeData == darkMode;

  // function to toggle between light and dark mode
  set toggleTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  // toggle between light and dark mode
  void toggleThemeMode() {
    _themeData = _themeData == lightMode ? darkMode : lightMode;
    notifyListeners();
  }
}
