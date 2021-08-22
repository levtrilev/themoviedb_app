import 'package:flutter/material.dart';
import 'package:themoviedb/images.dart';

class MovieDetailsScreenCastWidget extends StatelessWidget {
  const MovieDetailsScreenCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Series Cast',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Container(
            height: 260,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: 39,
                itemExtent: 120,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: Offset(0, 2)),
                        ],
                      ),
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: Column(
                          children: [
                            Image(image: AppImages.christny_father),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Marlon Brando',
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Don Vito Corleone',
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
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
