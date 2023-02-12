import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:paint/models/draw_points.dart';
import 'package:paint/screens/components/drawing_painter.dart';

class PaintScreen extends StatefulWidget {
  const PaintScreen({super.key});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  List<DrawPoints?> drawPoints = [];
  Color selectedColor = Colors.black;
  double strokeWidth = 5;
  List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.purple,
    Colors.green,
    Colors.pink,
    Colors.amber,
    Colors.amberAccent,
    Colors.white,
    Colors.teal,
    Colors.redAccent
  ];

  List<int> latIndex = [];

  void undo() {
    if (latIndex.isEmpty) {
      return;
    }
    drawPoints.removeRange(latIndex.last, drawPoints.length - 1);
    latIndex.removeLast();
  }

  void clear() {
    drawPoints.clear();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onPanStart: (details) {
                latIndex.add(drawPoints.isEmpty ? 0 : drawPoints.length - 1);
                setState(() {
                  drawPoints.add(DrawPoints(
                      details.localPosition,
                      Paint()
                        ..color = selectedColor
                        ..strokeWidth = strokeWidth
                        ..isAntiAlias = true
                        ..strokeCap = StrokeCap.round));
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  drawPoints.add(DrawPoints(
                      details.localPosition,
                      Paint()
                        ..color = selectedColor
                        ..strokeWidth = strokeWidth
                        ..isAntiAlias = true
                        ..strokeCap = StrokeCap.round));
                });
              },
              onPanEnd: (details) {
                setState(() {
                  drawPoints.add(null);
                });
              },
              child: CustomPaint(
                painter: DrawingPainter(drawPoints),
                size: size,
              ),
            ),
            Positioned(
                top: size.height * 0.01,
                right: size.width * 0.01,
                child: Row(
                  children: [
                    Slider.adaptive(
                      min: 01,
                      max: 40,
                      value: strokeWidth,
                      onChanged: (double value) {
                        setState(() {
                          strokeWidth = value;
                        });
                      },
                    ),
                    IconButton(
                        onPressed: undo, icon: const Icon(Icons.undo_rounded)),
                    TextButton(onPressed: clear, child: const Text('Clear')),
                  ],
                ))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
          color: const Color.fromARGB(255, 58, 57, 57),
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  colors.length, (index) => _buildColorSelector(colors[index])),
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildColorSelector(Color color) {
    bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () => setState(() {
        selectedColor = color;
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: isSelected ? 47 : 40,
          width: isSelected ? 47 : 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border:
                isSelected ? Border.all(color: Colors.white, width: 3) : null,
          ),
        ),
      ),
    );
  }
}
