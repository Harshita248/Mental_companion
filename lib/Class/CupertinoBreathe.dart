import 'package:flutter/material.dart';
import 'dart:math' as math;

class CupertinoBreathe extends StatefulWidget {
  @override
  _CupertinoBreatheState createState() => _CupertinoBreatheState();
}

class _CupertinoBreatheState extends State<CupertinoBreathe>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: CustomPaint(
          painter: _BreathePainter(
              CurvedAnimation(parent: _controller, curve: Curves.ease)),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _BreathePainter extends CustomPainter {
  _BreathePainter(
      this.animation, {
        this.count = 6,
      })  : circlePaint = Paint()
    ..color = Colors.cyan[200]
    ..blendMode = BlendMode.screen,
        super(repaint: animation);

  final Animation<double> animation;
  final int count;
  final Paint circlePaint;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide * 0.25) * animation.value;
    for (int index = 0; index < count; index++) {
      final indexAngle = (index * math.pi / count * 2);
      final angle = indexAngle + (math.pi * 1.5 * animation.value);
      final offset = Offset(math.sin(angle), math.cos(angle)) * radius * 0.985;
      canvas.drawCircle(center + offset * animation.value, radius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(_BreathePainter oldDelegate) =>
      animation != oldDelegate.animation;
}