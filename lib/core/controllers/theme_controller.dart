import 'package:flutter/material.dart';
import 'package:logger_beauty/log_level.dart';
import 'package:logger_beauty/logger_beauty.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    try {
      _isDarkMode = !_isDarkMode;
      notifyListeners();
    } catch (error) {
      logDebug("Error while switch theme: $error", level: LogLevel.error);
    }
  }
}
