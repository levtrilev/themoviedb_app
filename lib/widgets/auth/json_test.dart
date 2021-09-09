import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
/*
// use "flutter pub run build_runner build" togenerate file json_test.g.dart
// or use "flutter pub run build_runner watch"to follow changes in your files
*/
part 'json_test.g.dart';

class JsonTestWidget extends StatefulWidget {
  const JsonTestWidget({Key? key}) : super(key: key);

  @override
  _JsonTestWidgetState createState() => _JsonTestWidgetState();
}

class _JsonTestWidgetState extends State<JsonTestWidget> {
  @override
  void initState() {
    List<Person> persons = [];
    super.initState();
    const String _jsonExample =
        '''[{"name": "Иван", "surname": "Иванов"}, {"name": "Петр", "surname": "Петров"}]''';
        try {
          final json = jsonDecode(_jsonExample) as List<dynamic>;
          persons = json.map((dynamic e) => Person.fromJson(e as Map<String, dynamic>)).toList();
        } catch (error) {
          // ignore: avoid_print
          print(error);
        }
  final jsonResult = jsonEncode(persons.map((e) => e.toJson()).toList());
  // ignore: avoid_print
  print(jsonResult);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

@JsonSerializable()
class Person {
  /*
  // use it if JsonKey differ from your class firld name. it could be name: 'first_name'
  */
  @JsonKey(name: 'name')
  String name;
  String surname;

  Person({
    required this.name,
    required this.surname
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  // {
  //   return Person(
  //     name: json['name'] as String,
  //     surname: json['surname'] as String
  //   );
  // }

  Map<String, dynamic> toJson() => _$PersonToJson(this);
  // {
  //   return <String, dynamic>{
  //     "name": name,
  //     "surname": surname 
  //   };
  // }
}