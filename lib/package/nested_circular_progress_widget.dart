import 'dart:math';
import 'package:flutter/material.dart';

class NestedCircularProgress extends StatefulWidget {
  final double progress;
  final Color? progressColor;
  final Color? progressBackgroundColor;
  final double size;
  final Duration animationDuration;
  final double? strokeWidth;
  final Widget? child;

  const NestedCircularProgress({
    super.key,
    required this.progress,
    this.progressColor = Colors.blue,
    this.progressBackgroundColor = Colors.grey,
    this.size = 150,
    this.animationDuration = const Duration(seconds: 2),
    this.strokeWidth = 12,
    this.child,
  });

  @override
  State<NestedCircularProgress> createState() => _NestedCircularProgressState();
}

class _NestedCircularProgressState extends State<NestedCircularProgress> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: widget.progress),
      duration: widget.animationDuration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CustomPaint(
              size: Size(widget.size, widget.size),
              painter: CircularProgressPainter(
                progress: value,
                progressColor: widget.progressColor,
                backgroundColor: widget.progressBackgroundColor,
                strokeWidth: widget.strokeWidth,
              ),
            ),
            if (child != null) child,
          ],
        );
      },
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color? backgroundColor;
  final Color? progressColor;
  final double? strokeWidth;

  CircularProgressPainter({
    required this.progress,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
    this.strokeWidth = 8,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - strokeWidth! / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = progressColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.round;

    double sweepAngle = 2 * pi * (progress / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
