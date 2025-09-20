import 'dart:math';
import 'package:flutter/material.dart';

/// A customizable circular progress indicator with optional animation
/// and a child widget inside the circle.
///
/// This widget draws a circular progress bar with smooth animation,
/// using [TweenAnimationBuilder]. The progress can be customized
/// with colors, size, stroke width, and a child widget in the center.
///
/// Example:
/// ```dart
/// NestedCircularProgress(
///   progress: 75,
///   progressColor: Colors.blue,
///   progressBackgroundColor: Colors.grey.shade300,
///   size: 150,
///   strokeWidth: 12,
///   animationDuration: Duration(seconds: 2),
///   child: Text("75%"),
/// )
/// ```
class NestedCircularProgress extends StatefulWidget {
  /// The progress value (0–100).
  ///
  /// Represents the percentage of the circle that will be filled.
  final double progress;

  /// The color of the progress arc.
  final Color? progressColor;

  /// The color of the background circle (unfilled portion).
  final Color? progressBackgroundColor;

  /// The overall size (width and height) of the circular progress widget.
  final double size;

  /// The duration of the animation when progress changes.
  final Duration animationDuration;

  /// The thickness of the circular stroke.
  final double? strokeWidth;

  /// A widget to display at the center of the circular progress.
  ///
  /// Commonly used to display text (e.g. percentage) or icons.
  final Widget? child;

  /// Creates a [NestedCircularProgress] widget.
  ///
  /// - [progress] must be between 0 and 100.
  /// - [progressColor] sets the arc color (default: [Colors.blue]).
  /// - [progressBackgroundColor] sets the circle color (default: [Colors.grey]).
  /// - [size] controls the diameter of the widget (default: 150).
  /// - [animationDuration] controls how long the progress animates (default: 2s).
  /// - [strokeWidth] controls the arc thickness (default: 12).
  /// - [child] places a widget in the center.
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

/// A painter that draws a circular progress arc with a background circle.
///
/// Used internally by [NestedCircularProgress] but can also be reused
/// directly inside a [CustomPaint] widget.
class CircularProgressPainter extends CustomPainter {
  /// The current progress percentage (0–100).
  final double progress;

  /// The background circle color.
  final Color? backgroundColor;

  /// The progress arc color.
  final Color? progressColor;

  /// The stroke width of the circle and arc.
  final double? strokeWidth;

  /// Creates a [CircularProgressPainter].
  ///
  /// - [progress] defines how much of the circle is filled.
  /// - [backgroundColor] sets the base circle color.
  /// - [progressColor] sets the arc color.
  /// - [strokeWidth] defines line thickness.
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

    // Draw base circle
    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = progressColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.round;

    // Sweep angle based on progress
    double sweepAngle = 2 * pi * (progress / 100);

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // start angle (top)
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
