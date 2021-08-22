import 'package:flutter/material.dart';
import 'package:themoviedb/elements/radial_percent_widget.dart';
import 'package:themoviedb/images.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_screen_cast_widget.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopPosterWidget(),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: _MovieNameWidget(),
        ),
        _ScoreWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 70,
          ),
          child: _SummaryWidget(),
        ),
        MovieDetailsScreenCastWidget(),
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 50,
            ),
            Expanded(child: Image(image: AppImages.godfather_mainpic_min432)),
          ],
        ),
        Positioned(
          top: 16,
          left: 16,
          bottom: 16,
          child: Image(image: AppImages.christny_father),
        ),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      text: TextSpan(
        children: [
          TextSpan(
              text: 'Tom Clancy`s Without Remorse',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
          TextSpan(
            text: '  (2021)',
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  static const double rating = 0.79;
  const _ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                child: RadialPercentWidget(
                  child: Text(
                    '${(100 * rating).toStringAsFixed(0)}%',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  rating: rating,
                  backgroundColor: Colors.black,
                  ratingColor: Colors.green,
                  restColor: Colors.grey,
                  lineWidth: 6,
                  lineMargin: 3,
                ),
              ),
              Text('User Score'),
            ],
          ),
        ),
        Container(
          height: 15,
          width: 1,
          color: Colors.grey[700],
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(Icons.play_arrow),
              Text('Play Trailer'),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'R, 04/29/21 (US) 1h 49m  Action, Adventure, Thriller, War',
      style: TextStyle(fontSize: 16, color: Colors.white),
      textAlign: TextAlign.center,
    );
  }
}
