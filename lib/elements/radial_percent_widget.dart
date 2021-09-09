import 'dart:math';

import 'package:flutter/material.dart';

class RadialPercentWidget extends StatelessWidget {
  final Widget child;
  final double rating;
  final Color backgroundColor;
  final Color ratingColor;
  final Color restColor;
  final double lineWidth;
  final double lineMargin;
  const RadialPercentWidget({
    Key? key,
    required this.child,
    required this.rating,
    required this.backgroundColor,
    required this.ratingColor,
    required this.restColor,
    required this.lineWidth,
    required this.lineMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: MyCustomPainter(
            backgroundColor: backgroundColor,
            restColor: restColor,
            ratingColor: ratingColor,
            rating: rating,
            lineWidth: lineWidth,
            lineMargin: lineMargin,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Center(
            child: child,
          ),
        ),
      ],
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final double rating;
  final Color backgroundColor;
  final Color ratingColor;
  final Color restColor;
  final double lineWidth;
  final double lineMargin;
  MyCustomPainter({
    required this.rating,
    required this.backgroundColor,
    required this.ratingColor,
    required this.restColor,
    required this.lineWidth,
    required this.lineMargin,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final innerRectangleStartOffset =
        Offset((lineWidth) / 2 + lineMargin, (lineWidth) / 2 + lineMargin);
    // Offset(lineMargin + lineWidth, lineMargin + lineWidth);
    final innerOvalSize = Size(size.width - lineWidth - 2 * lineMargin,
        size.height - lineWidth - 2 * lineMargin);
    // final innerOvalSize = Size(size.width - lineWidth - 2 * lineMargin,
    //     size.height - lineWidth - 2 * lineMargin);
    drawBackgroundOval(canvas, size);
    drawRestArc(canvas, innerRectangleStartOffset, innerOvalSize);
    drawRatingArc(canvas, innerRectangleStartOffset, innerOvalSize);
  }

  void drawRatingArc(
      Canvas canvas, Offset innerRectangleStartOffset, Size innerOvalSize) {
    final restPaint = Paint();
    restPaint.color = ratingColor;
    restPaint.style = PaintingStyle.stroke;
    restPaint.strokeWidth = lineWidth;
    restPaint.strokeCap = StrokeCap.round;
    canvas.drawArc(innerRectangleStartOffset & innerOvalSize, -pi / 2,
        rating * 2 * pi, false, restPaint);
  }

  void drawRestArc(
      Canvas canvas, Offset innerRectangleStartOffset, Size innerOvalSize) {
    final feelPaint = Paint();
    feelPaint.color = restColor;
    feelPaint.style = PaintingStyle.stroke;
    feelPaint.strokeWidth = lineWidth;
    final _restRating = (1.0 - rating) * 2 * pi;
    canvas.drawArc(innerRectangleStartOffset & innerOvalSize,
        rating * 2 * pi - pi / 2, _restRating, false, feelPaint);
  }

  void drawBackgroundOval(Canvas canvas, Size size) {
    final backgroundPaint = Paint();
    backgroundPaint.color = backgroundColor;
    backgroundPaint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyTestCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.green;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 30, paint);
    paint.color = Colors.blue;
    canvas.drawRect(const Rect.fromLTWH(10, 10, 50, 40), paint);
    paint.strokeWidth = 10;
    canvas.drawRect(Offset.zero & const Size(30, 30), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
