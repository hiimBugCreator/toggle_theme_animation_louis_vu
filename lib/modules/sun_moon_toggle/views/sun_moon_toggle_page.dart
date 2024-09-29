import 'package:flutter/material.dart';
import 'package:toggle_theme_animation_louis_vu/core/controllers/theme_controller.dart';
import 'package:toggle_theme_animation_louis_vu/modules/sun_moon_toggle/widgets/sun_moon_toggle_widget.dart';

class SunMoonTogglePage extends StatelessWidget {
  const SunMoonTogglePage(this.themeController, {super.key});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SunMoonToggle(controller: themeController),
    );
  }
}
