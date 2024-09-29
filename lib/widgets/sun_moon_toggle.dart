import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger_beauty/log_level.dart';
import 'package:logger_beauty/logger_beauty.dart';
import 'package:toggle_theme_animation_louis_vu/widgets/star_background.dart';
import '../constants/constant.dart';
import '../controllers/theme_controller.dart';
import 'circle_painter.dart';
import 'cloud_background.dart';

class SunMoonToggle extends StatefulWidget {
  final ThemeController controller;

  const SunMoonToggle({super.key, required this.controller});

  @override
  State<StatefulWidget> createState() => _SunMoonToggleState();
}

class _SunMoonToggleState extends State<SunMoonToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _thumbAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: ConstantValue.animationDuration,
    );
    _thumbAnimation = Tween<double>(
      begin:
          widget.controller.isDarkMode ? ConstantValue.buttonSize * 3.15 : 0.0,
      end: ConstantValue.buttonSize * 3.15,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var baseCircleSize = ConstantValue.buttonSize * 1.5;
    return GestureDetector(
      onTap: () {
        try {
          widget.controller.toggleTheme();
          if (widget.controller.isDarkMode) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        } catch (e) {
          logDebug(e, level: LogLevel.error);
        }
      },
      child: Container(
        width: ConstantValue.toggleSize.width,
        height: ConstantValue.toggleSize.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), // Ensure it's rounded
          color: widget.controller.isDarkMode
              ? ColorConstants.darkToggleBackground
              : ColorConstants.lightToggleBackground,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Stack(
            children: [
              widget.controller.isDarkMode
                  ? const StarsBackground()
                  : const CloudsBackground(),
              AnimatedBuilder(
                animation: _thumbAnimation,
                builder: (context, child) {
                  return Positioned(
                    right: widget.controller.isDarkMode
                        ? null
                        : ConstantValue.toggleSize.width * 0.2,
                    left: widget.controller.isDarkMode
                        ? ConstantValue.toggleSize.width * 0.2
                        : null,
                    child: IgnorePointer(
                      child: CustomPaint(
                        size: Size(baseCircleSize * 4, baseCircleSize * 1.25),
                        painter: CirclePainter(widget.controller.isDarkMode
                            ? Colors.grey.withOpacity(0.1)
                            : Colors.white.withOpacity(0.1)),
                      ),
                    ),
                  );
                },
              ),
              // Sun and Moon Icons with animation and shadow
              AnimatedBuilder(
                animation: _thumbAnimation,
                builder: (context, child) {
                  return Positioned(
                    left: _thumbAnimation.value,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Shadow color
                                blurRadius: 8, // Shadow blur radius
                                offset: const Offset(2, 2), // Shadow offset
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: baseCircleSize,
                            height: baseCircleSize,
                            child: SvgPicture.asset(
                              widget.controller.isDarkMode
                                  ? Assets.moonIcon
                                  : Assets.sunIcon,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
