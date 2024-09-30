import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger_beauty/log_level.dart';
import 'package:logger_beauty/logger_beauty.dart';
import 'package:toggle_theme_animation_louis_vu/config/config.dart';
import 'package:toggle_theme_animation_louis_vu/core/controllers/theme_controller.dart';

import 'circle_painter.dart';
import 'cloud_background.dart';
import 'star_background.dart';

class SunMoonToggle extends StatefulWidget {
  final ThemeController controller;
  final double buttonSize;

  const SunMoonToggle({
    super.key,
    required this.controller,
    this.buttonSize = NumericConstant.buttonSize,
  });

  @override
  State<StatefulWidget> createState() => _SunMoonToggleState();
}

class _SunMoonToggleState extends State<SunMoonToggle>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _hoverAnimationController;
  late Animation<double> _thumbAnimation;
  late Animation<double> _hoverAnimation;
  bool isHovering = false;

  late var baseCircleSize = widget.buttonSize * 1.5;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: NumericConstant.animationDuration,
    );
    _hoverAnimationController = AnimationController(
      vsync: this,
      duration: NumericConstant.hoverAnimationDuration,
    );
    if (widget.controller.isDarkMode) {
      _animationController.value = 1.0;
    }

    var buttonDistance = widget.buttonSize * 3.15;
    _thumbAnimation = Tween<double>(
      begin: widget.controller.isDarkMode ? buttonDistance : 0.0,
      end: buttonDistance,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _hoverAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _hoverAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _hoverAnimationController.dispose();
    super.dispose();
  }

  void _onHover(bool hovering) {
    setState(() {
      isHovering = hovering;
      if (hovering) {
        _hoverAnimationController.forward();
      } else {
        _hoverAnimationController.reverse();
      }
    });
  }

  get _clouds => AnimatedPositioned(
        duration: NumericConstant.animationDuration,
        top: widget.controller.isDarkMode ? widget.buttonSize : 0,
        bottom: widget.controller.isDarkMode ? -widget.buttonSize : 0,
        left: 0,
        right: 0,
        child: AnimatedOpacity(
          opacity: widget.controller.isDarkMode ? 0 : 1,
          duration: NumericConstant.animationDuration,
          child: const CloudsBackground(),
        ),
      );

  get _stars => AnimatedPositioned(
        duration: NumericConstant.animationDuration,
        top: widget.controller.isDarkMode ? 0 : -widget.buttonSize,
        bottom: widget.controller.isDarkMode ? 0 : widget.buttonSize,
        left: 0,
        right: 0,
        child: AnimatedOpacity(
          opacity: widget.controller.isDarkMode ? 1 : 0,
          duration: NumericConstant.animationDuration,
          child: const StarsBackground(),
        ),
      );

  get _shiny => AnimatedBuilder(
        animation: Listenable.merge([_thumbAnimation, _hoverAnimation]),
        builder: (context, child) {
          double hoverOffset = isHovering
              ? (widget.controller.isDarkMode
                  ? -_hoverAnimation.value
                  : _hoverAnimation.value)
              : 0.0;
          double customPaintWidth = baseCircleSize * 4;
          double customPaintHeight = baseCircleSize * 1.25;
          return Positioned(
            right: widget.controller.isDarkMode
                ? -NumericConstant.toggleSize.width * 0.4155
                : NumericConstant.toggleSize.width * 0.2,
            left: widget.controller.isDarkMode
                ? NumericConstant.toggleSize.width * 0.2
                : -NumericConstant.toggleSize.width * 0.4155,
            child: IgnorePointer(
              child: Transform.translate(
                offset: Offset(hoverOffset, 0),
                child: CustomPaint(
                  size: Size(customPaintWidth, customPaintHeight),
                  painter: CirclePainter(
                    Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ),
          );
        },
      );

  get _thumb => AnimatedBuilder(
        animation: Listenable.merge([_thumbAnimation, _hoverAnimation]),
        builder: (context, child) {
          double hoverOffset = isHovering
              ? (widget.controller.isDarkMode
                  ? -_hoverAnimation.value
                  : _hoverAnimation.value)
              : 0.0;
          return Positioned(
            left: _thumbAnimation.value + hoverOffset,
            child: Padding(
              padding: const EdgeInsets.all(NumericConstant.paddingButton),
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.shadowColor,
                        blurRadius: 8,
                        offset: const Offset(2, 2),
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
      );

  @override
  Widget build(BuildContext context) {
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
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: AnimatedContainer(
          duration: NumericConstant.animationDuration,
          width: NumericConstant.toggleSize.width,
          height: NumericConstant.toggleSize.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.buttonSize),
            color: widget.controller.isDarkMode
                ? ColorConstants.darkToggleBackground
                : ColorConstants.lightToggleBackground,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.buttonSize),
            child: Stack(
              children: [
                _clouds,
                _stars,
                _shiny,
                _thumb,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
