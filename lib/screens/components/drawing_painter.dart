import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paint/models/draw_points.dart';

class DrawingPainter extends CustomPainter {
  final List<DrawPoints?> drawpoints;
  DrawingPainter(this.drawpoints);

  List<Offset> offsetList = [];
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawpoints.length-1; i++) {
      if (drawpoints[i] != null && drawpoints[i + 1] != null) {
        canvas.drawLine(drawpoints[i]!.offset, drawpoints[i + 1]!.offset,
            drawpoints[i]!.paint);
      } else if (drawpoints[i] != null && drawpoints[i + 1] == null) {
        offsetList.clear();
        offsetList.add(drawpoints[i]!.offset);
        canvas.drawPoints(PointMode.points, offsetList, drawpoints[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
