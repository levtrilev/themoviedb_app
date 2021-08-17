import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/images.dart';

class Movie {
  AssetImage imageName;
  String title;
  String time;
  String description;

  Movie(
      {required this.imageName,
      required this.title,
      required this.time,
      required this.description});
}

class MovieListWidget extends StatelessWidget {
  final _movies = [
    Movie(
        imageName: AppImages.escape_from_shousheng,
        title: 'Побег из Шоушенка',
        time: '1 января 2020',
        description:
            'Это такой захватывающий сюжет про побег оттуда откуда невозможно побежать'),
    Movie(
        imageName: AppImages.christny_father,
        title: 'Крестный отец',
        time: '2 февраля 2021',
        description:
            'Дон Карлеоне выслушивает плачущего отца изнасилованной девушки и отвечает: Ты приходишь в мой дом в день свадьбы моей дочери'),
    Movie(
        imageName: AppImages.indian_film,
        title: 'Радж Капур раджает',
        time: '31 декабря 1980',
        description:
            'Слезы умиления текут рекой. Бравый простой веселый прекрасный индийский парень размахивает руками и враги падают на расстоянии пяти метров. Близняшки спасены и вот их свадьба!'),
    Movie(
        imageName: AppImages.christny_father,
        title: 'Смертельная смерть',
        time: '31 июля 1989',
        description:
            'Фильм удостоен шести номинаций на «Оскар», в том числе и как лучший фильм года. Шоушенк — название тюрьмы. И если тебе нет еще 30-ти, а ты получаешь пожизненное, то приготовься к худшему: для тебя выхода из Шоушенка не будет! Актриса Рита Хэйворт — любимица всей Америки. Энди Дифрейну она тоже очень нравилась. Рита никогда не слышала о существовании Энди, однако жизнь Дифрейну, бывшему вице-президенту крупного банка, осужденному за убийство жены и ее любовника, Рита Хэйворт все-таки спасла.'),
  ];
  MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _movies.length,
      itemExtent: 163,
      itemBuilder: (BuildContext context, int index) {
        final movie = _movies[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 2)),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: Row(
                  children: [
                    Image(
                      image: movie.imageName,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            movie.title,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            movie.time,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            movie.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    print('times card pressed');
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
