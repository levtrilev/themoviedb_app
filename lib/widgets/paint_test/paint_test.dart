import 'dart:math';

import 'package:flutter/material.dart';

class PaintTestWidget extends StatelessWidget {
  static const rating = 0.67;
  const PaintTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
            ),
          ),
          child: CustomPaint(
            painter: MyTestCustomPainter(),
          ),
        ),
        SizedBox(
          height: 100,
        ),
        Container(
          width: 190,
          height: 190,
          child: RadialPercentWidget(
            backgroundColor: Colors.deepPurple,
            restColor: Colors.yellow,
            ratingColor: Colors.red,
            rating: rating,
            lineWidth: 9,
            child: Text(
              '${(100 * rating).toStringAsFixed(0)}%',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}

class RadialPercentWidget extends StatelessWidget {
  final Widget child;
  final double rating;
  final Color backgroundColor;
  final Color ratingColor;
  final Color restColor;
  final double lineWidth;
  const RadialPercentWidget({
    Key? key,
    required this.child,
    required this.rating,
    required this.backgroundColor,
    required this.ratingColor,
    required this.restColor,
    required this.lineWidth,
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
  MyCustomPainter({
    required this.rating,
    required this.backgroundColor,
    required this.ratingColor,
    required this.restColor,
    required this.lineWidth,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final lineMargin = 2.0;
    final innerRectangleStartOffset =
        Offset(lineMargin + lineWidth, lineMargin + lineWidth);
    final innerOvalSize = Size(size.width - 2 * lineWidth - 2 * lineMargin,
        size.height - 2 * lineWidth - 2 * lineMargin);
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
    canvas.drawRect(Rect.fromLTWH(10, 10, 50, 40), paint);
    paint.strokeWidth = 10;
    canvas.drawRect(Offset.zero & Size(30, 30), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
