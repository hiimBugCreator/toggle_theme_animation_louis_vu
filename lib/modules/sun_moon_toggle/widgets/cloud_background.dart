import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toggle_theme_animation_louis_vu/config/config.dart';

class CloudsBackground extends StatelessWidget {
  const CloudsBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: SizedBox(
            width: NumericConstant.toggleSize.width,
            height: NumericConstant.toggleSize.height,
            child: SvgPicture.asset(
              Assets.cloudIcon,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          child: SizedBox(
            width: NumericConstant.toggleSize.width,
            height: NumericConstant.toggleSize.height,
            child: SvgPicture.asset(
              Assets.cloudBackIcon,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
