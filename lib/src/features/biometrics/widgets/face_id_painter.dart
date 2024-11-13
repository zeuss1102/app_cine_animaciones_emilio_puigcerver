import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;
import 'package:flutter_movie_ticket/src/core/constants/constants.dart';

import '../animations/animations.dart';

class FaceIDPainter extends CustomPainter {
  final FaceIDAnimationController animation;

  FaceIDPainter({
    required this.animation,
  }) : super(repaint: animation.controller);

  @override
  void paint(Canvas canvas, Size size) {
    // Verificar que el tamaño de `size` es cuadrado.
    assert(size.width == size.height, 'El tamaño debe ser cuadrado');
    
    final double s = size.height; // Lado del lienzo
    final double oneHalf = s / 2;
    final double oneThird = s / 3;
    final double twoThird = 2 * oneThird;
    final Offset center = Offset(oneHalf, oneHalf);
    final double radius = math.min(oneHalf, oneHalf);

    // Animaciones
    final double moveR1 = animation.moveR1.value;
    final double moveL1 = animation.moveL1.value;
    final double moveR2 = animation.moveR2.value;
    final double moveU1 = animation.moveU1.value;
    final double moveD1 = animation.moveD1.value;
    final double moveU2 = animation.moveU2.value;

    final double moveX = moveR1 + moveL1 + moveR2;
    final double moveY = moveU1 + moveD1 + moveU2;

    final bool canBlink =
        animation.controller.value >= .6 && animation.controller.value <= .65;
    final bool canShowCheck1 = animation.controller.value >= .9;
    final bool canShowCheck2 = animation.controller.value >= .95;
    final double check1X = animation.check1X.value;
    final double check1Y = animation.check1Y.value;
    final double check2X = animation.check2X.value;
    final double check2Y = animation.check2Y.value;
    final double closeRRect = animation.closeRRect.value;
    final double borderRadiusRRect = animation.borderRadiusRRect.value;
    final double faceOpacity = animation.faceOpacity.value;

    // Pintura general
    final double strokeWidth = s * 0.06;
    final Paint facePaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = AppColors.primaryColor.withOpacity(faceOpacity)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Ojos
    final double eyeLength = s * .1;
    final Paint eyeBlinkPaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = canBlink ? Colors.transparent : AppColors.primaryColor.withOpacity(faceOpacity)
      ..strokeCap = StrokeCap.round;

    final Offset leftEyeP1 = Offset(oneThird + moveX, oneThird + moveY);
    final Offset leftEyeP2 = Offset(oneThird + moveX, oneThird + eyeLength + moveY);
    canvas.drawLine(leftEyeP1, leftEyeP2, facePaint);

    final Offset rightEyeP1 = Offset(twoThird + moveX, oneThird + moveY);
    final Offset rightEyeP2 = Offset(twoThird + moveX, oneThird + eyeLength + moveY);
    canvas.drawLine(rightEyeP1, rightEyeP2, eyeBlinkPaint);

    // Sonrisa
    final Rect rect = Rect.fromCircle(
      center: Offset(center.dx + moveX, center.dy + moveY),
      radius: s * .225,
    );
    final double startAngle = vector.radians(130);
    final double sweepAngle = vector.radians(-90);
    canvas.drawArc(rect, startAngle, sweepAngle, false, facePaint);

    // Nariz
    final double offsetFactor = s * 0.006;
    final double noseOffsetX = s * 0.015;
    final double noseOffsetY = s * 0.175;
    final double noseHeight = s * 0.225;
    final double noseWidth = s * 0.05;

    final Path nosePath = Path()
      ..moveTo(
        (oneHalf + noseOffsetX) + moveX * offsetFactor,
        oneThird + moveY,
      )
      ..lineTo(
        (oneHalf + noseOffsetX) + moveX * offsetFactor,
        oneThird + moveY + noseOffsetY,
      )
      ..quadraticBezierTo(
        (oneHalf + noseOffsetX) + moveX * offsetFactor,
        oneThird + noseHeight + moveY,
        (oneHalf - noseWidth) + moveX * offsetFactor,
        oneThird + noseHeight + moveY,
      );
    canvas.drawPath(nosePath, facePaint);

    // Bordes
    final Paint paintBorders = Paint()
      ..style = PaintingStyle.stroke
      ..color = AppColors.primaryColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromCircle(center: center, radius: radius),
      Radius.circular(borderRadiusRRect),
    );
    canvas.drawRRect(rRect, paintBorders);

    // Separadores de borde
    final Paint lines = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white
      ..strokeWidth = s * 0.07;

    final double closeOffsetYP1 = oneThird * (1 + closeRRect);
    final double closeOffsetYP2 = oneThird * (2 - closeRRect);

    canvas.drawLine(
      Offset(0, closeOffsetYP1),
      Offset(0, closeOffsetYP2),
      lines,
    );
    canvas.drawLine(
      Offset(s, closeOffsetYP1),
      Offset(s, closeOffsetYP2),
      lines,
    );
    canvas.drawLine(
      Offset(closeOffsetYP1, 0),
      Offset(closeOffsetYP2, 0),
      lines,
    );
    canvas.drawLine(
      Offset(closeOffsetYP1, s),
      Offset(closeOffsetYP2, s),
      lines,
    );

    // Bordes de los círculos
    final Paint circle = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.primaryColor
      ..strokeWidth = s * 0.025;

    final double capRadius = s * .03;
    canvas.drawCircle(Offset(0, closeOffsetYP1), capRadius, circle);
    canvas.drawCircle(Offset(0, closeOffsetYP2), capRadius, circle);
    canvas.drawCircle(Offset(s, closeOffsetYP1), capRadius, circle);
    canvas.drawCircle(Offset(s, closeOffsetYP2), capRadius, circle);
    canvas.drawCircle(Offset(closeOffsetYP1, 0), capRadius, circle);
    canvas.drawCircle(Offset(closeOffsetYP2, 0), capRadius, circle);
    canvas.drawCircle(Offset(closeOffsetYP1, s), capRadius, circle);
    canvas.drawCircle(Offset(closeOffsetYP2, s), capRadius, circle);

    // Check
    final Paint check1 = Paint()
      ..strokeCap = StrokeCap.round
      ..color = canShowCheck1 ? AppColors.primaryColor : Colors.transparent
      ..strokeWidth = strokeWidth;
    canvas.drawLine(
      Offset(s * .275, oneHalf),
      Offset(check1X, check1Y),
      check1,
    );

    final Paint check2 = Paint()
      ..strokeCap = StrokeCap.round
      ..color = canShowCheck2 ? AppColors.primaryColor : Colors.transparent
      ..strokeWidth = strokeWidth;
    canvas.drawLine(
      Offset(oneHalf, s * .7),
      Offset(check2X, check2Y),
      check2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
