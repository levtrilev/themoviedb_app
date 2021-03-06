import 'package:flutter/material.dart';

import 'package:themoviedb/domain/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details_credits.dart';
import 'package:themoviedb/elements/radial_percent_widget.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_screen_cast_widget.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _TopPosterWidget(),
        Padding(
          padding: EdgeInsets.all(18.0),
          child: _MovieNameWidget(),
        ),
        _ScoreWidget(),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          child: _SummaryWidget(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          child: _DescriptionWidget(),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: _CrewWidget(),
        ),
        MovieDetailsScreenCastWidget(),
      ],
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final overview = model?.movieDetails?.overview ?? '';

    return Column(
      children: [
        const Text('Overview',
            style: TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.left),
        Text(
          overview,
          style: const TextStyle(fontSize: 14, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 411 / 203,
      child: Stack(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              Expanded(
                  child: backdropPath != null
                      ? Image.network(ApiClient.imageUrl(backdropPath))
                      : const SizedBox.shrink()),
              //Expanded(child: Image(image: AppImages.godfatherMainpicMin432)),
            ],
          ),
          Positioned(
            top: 16,
            left: 16,
            bottom: 16,
            child: posterPath != null
                ? Image.network(ApiClient.imageUrl(posterPath))
                : const SizedBox.shrink(),
            //child: Image(image: AppImages.christnyFather),
          ),
          Positioned(
            top: 4,
            left: 360,
            //bottom: 16,
            child: IconButton(
              onPressed: () => model?.toggleFavorite(),
              icon: Icon(model?.isFavorite == true ? Icons.favorite : Icons.favorite_outline),
              color: Colors.white,
              // focusColor: Colors.red,
              // hoverColor: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final originalTitle = model?.movieDetails?.originalTitle;
    final year = model?.movieDetails?.releaseDate?.year.toString() ??
        'no year available';
    return RichText(
      maxLines: 3,
      text: TextSpan(
        children: [
          TextSpan(
              text: originalTitle ??
                  'no originalTitle...', //'Tom Clancy`s Without Remorse',
              style:
                  const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
          TextSpan(
            text: '  ($year)',
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  //static const double rating = 0.79;
  const _ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    final voteAverage = movieDetails?.voteAverage ?? 0;
    final rating = voteAverage.toDouble() / 10;
    final videos = movieDetails?.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 55,
                height: 55,
                child: RadialPercentWidget(
                  child: Text(
                    '${(100 * rating).toStringAsFixed(0)}%',
                    style: const TextStyle(
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
              const Text('User Score'),
            ],
          ),
        ),
        Container(
          height: 15,
          width: 1,
          color: Colors.grey[700],
        ),
        trailerKey != null
            ? TextButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  MainNavigationRouteNames.movieTrailerWidget,
                  arguments: trailerKey,
                ),
                child: Row(
                  children: const [
                    Icon(Icons.play_arrow),
                    Text('Play Trailer'),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    if (model == null) return const SizedBox.shrink();
    final movieDetails = model.movieDetails;

    var texts = <String>[];
    final releaseDate = movieDetails?.releaseDate;
    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    }

    final productionCountries = movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      texts.add('(${productionCountries.first.iso})');
    }

    final runtime = movieDetails?.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    final minutes = duration.inMinutes.remainder(60);
    final hours = duration.inHours;
    if (runtime != 0) {
      texts.add('${hours}h ${minutes}m -');
    }

    final genres = movieDetails?.genres;

    if (genres != null && genres.isNotEmpty) {
      var genresNames = <String>[];
      for (var genre in genres) {
        genresNames.add(genre.name);
      }
      texts.add(genresNames.join(', '));
    }
    return Text(
      texts.join(' '),
      //'R, 04/29/21 (US) 1h 49m  Action, Adventure, Thriller, War',
      style: const TextStyle(fontSize: 16, color: Colors.white),
      textAlign: TextAlign.center,
    );
  }
}

class _CrewWidget extends StatelessWidget {
  const _CrewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    if (model == null) return const SizedBox.shrink();
    var crew = model.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    crew = crew.sublist(0, crew.length >= 4 ? 4 : crew.length);

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CrewItemWidget(itemNumber: 0, crew: crew),
                const SizedBox(
                  height: 12,
                ),
                _CrewItemWidget(itemNumber: 1, crew: crew),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CrewItemWidget(itemNumber: 2, crew: crew),
                const SizedBox(
                  height: 12,
                ),
                _CrewItemWidget(itemNumber: 3, crew: crew),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _CrewItemWidget extends StatelessWidget {
  final int itemNumber;
  final List<Crew>? crew;
  const _CrewItemWidget({
    Key? key,
    required this.itemNumber,
    this.crew,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const nameStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    if (crew!.length < itemNumber + 1) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(crew![itemNumber].name, style: nameStyle),
        Text(crew![itemNumber].job, style: nameStyle),
      ],
    );
  }
}
