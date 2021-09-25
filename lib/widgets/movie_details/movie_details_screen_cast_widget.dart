import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details_credits.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';

class MovieDetailsScreenCastWidget extends StatelessWidget {
  const MovieDetailsScreenCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            'Series Cast',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 260,
            child: Scrollbar(
              child: _CastListWidget(),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Full Cast & Crew',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CastListWidget extends StatelessWidget {
  const _CastListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    if (model == null) return const SizedBox.shrink();
    final cast = model.movieDetails?.credits.cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    var photoCast = <Cast>[];
    for (Cast actor in cast) {
      if (actor.profilePath != null) {
        photoCast.add(actor);
      }
    }
    return ListView.builder(
      itemCount: photoCast.length,
      itemExtent: 120,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final actor = photoCast[index];
        final photoPath = actor.profilePath ?? '';
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2)),
              ],
            ),
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Column(
                children: [
                  Image.network(ApiClient.imageUrl(photoPath)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        actor.name,
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      actor.character,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
