import 'package:flutter/material.dart';

class ArrowPainter extends CustomPainter {
  final bool pointsLeft;

  ArrowPainter({required this.pointsLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final path = Path();
    final arrowHeadWidth = size.height;

    if (pointsLeft) {
      path.moveTo(0, size.height / 2);
      path.lineTo(arrowHeadWidth, 0);
      path.lineTo(arrowHeadWidth, size.height * 0.25);
      path.lineTo(size.width, size.height * 0.25);
      path.lineTo(size.width, size.height * 0.75);
      path.lineTo(arrowHeadWidth, size.height * 0.75);
      path.lineTo(arrowHeadWidth, size.height);
      path.close();
    } else {
      path.moveTo(0, size.height * 0.25);
      path.lineTo(size.width - arrowHeadWidth, size.height * 0.25);
      path.lineTo(size.width - arrowHeadWidth, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(size.width - arrowHeadWidth, size.height);
      path.lineTo(size.width - arrowHeadWidth, size.height * 0.75);
      path.lineTo(0, size.height * 0.75);
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) =>
      oldDelegate.pointsLeft != pointsLeft;
}
