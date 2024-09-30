import 'package:flutter/cupertino.dart';
import 'package:toggle_theme_animation_louis_vu/config/config.dart';

class CirclePainter extends CustomPainter {
  final Color color;

  CirclePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double radiusIncrement =
        size.width / (2 * NumericConstant.numberOfCirclesShine);
    var reduce = 15;
    for (int i = 1; i <= NumericConstant.numberOfCirclesShine; i++) {
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = color;
      reduce -= i * 2;
      canvas.drawCircle(center, radiusIncrement * i * reduce / 10, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
