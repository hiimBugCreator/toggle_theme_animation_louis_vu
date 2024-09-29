import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toggle_theme_animation_louis_vu/constants/constant.dart';

class CloudsBackground extends StatelessWidget {
  const CloudsBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: SizedBox(
            width: ConstantValue.toggleSize.width, // Đảm bảo không vượt quá Container
            height: ConstantValue.toggleSize.height, // Điều chỉnh kích thước
            child: SvgPicture.asset(
              Assets.cloudIcon,
              fit: BoxFit.cover, // Đảm bảo hình ảnh được cắt đúng kích thước
            ),
          ),
        ),
        Positioned(
          child: SizedBox(
            width: ConstantValue.toggleSize.width, // Điều chỉnh lại cho phù hợp
            height: ConstantValue.toggleSize.height, // Đảm bảo không vượt quá container
            child: SvgPicture.asset(
              Assets.cloudBackIcon,
              fit: BoxFit.cover, // Cắt theo container
            ),
          ),
        ),
      ],
    );
  }
}
