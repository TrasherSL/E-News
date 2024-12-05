import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  // Notification management
  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  void toggleNotifications(bool isEnabled) {
    _notificationsEnabled = isEnabled;
    notifyListeners();
  }
}

