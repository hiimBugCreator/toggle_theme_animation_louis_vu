import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toggle_theme_animation_louis_vu/constants/constant.dart';

class StarsBackground extends StatelessWidget {
  const StarsBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: 43.0,
        top: 23.0,
        bottom: 19.0,
        child: SizedBox(
          width: ConstantValue.toggleSize.width * 142 / 369,
          height: ConstantValue.toggleSize.height * 93 / 145,
          child: SvgPicture.asset(
            Assets.starIcon,
          ),
        ),
      ),
    ]);
  }
}