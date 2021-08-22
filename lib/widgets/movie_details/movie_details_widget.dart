import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_main_info_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  final movieId;
  const MovieDetailsWidget({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  _MovieDetailsWidgetState createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tom Clancy`s Without Remorse',
          ),
        ),
        body: ColoredBox(
          color: Color.fromRGBO(24, 23, 27, 1.0),
          child: ListView(
            children: [
              MovieDetailsMainInfoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
