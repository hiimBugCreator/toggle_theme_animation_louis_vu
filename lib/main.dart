import 'package:flutter/material.dart';
import 'package:toggle_theme_animation_louis_vu/widgets/sun_moon_toggle.dart';

import 'app_theme.dart';
import 'controllers/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController _themeController = ThemeController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeController,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              _themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: Scaffold(
            appBar: AppBar(title: const Text('Sun/Moon Toggle')),
            body: Center(
              child: SunMoonToggle(controller: _themeController),
            ),
          ),
        );
      },
    );
  }
}
