import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    try {
      _isDarkMode = !_isDarkMode;
      notifyListeners();
    } catch (error) {
      print("Error toggling theme: $error");
    }
  }
}
