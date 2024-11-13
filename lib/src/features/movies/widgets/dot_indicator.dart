import 'package:flutter/material.dart';
import 'package:flutter_movie_ticket/src/core/constants/constants.dart';

class DotIndicator extends Decoration {
  const DotIndicator();

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return DotIndicatorPainter(onChanged);
  }
}

class DotIndicatorPainter extends BoxPainter {
  const DotIndicatorPainter([VoidCallback? onChanged]) : super(onChanged);

  static const double radius = 8.0;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // Verifica si el tamaño es nulo y maneja posibles null values de forma segura.
    if (configuration.size == null) return;

    final double dx = configuration.size!.width / 2;
    final double dy = configuration.size!.height + radius / 2;
    final Offset circleOffset = offset + Offset(dx, dy);

    final Paint paint = Paint()..color = AppColors.primaryColor;

    // Dibuja el círculo indicador.
    canvas.drawCircle(circleOffset, radius, paint);
  }
}

