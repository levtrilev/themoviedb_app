// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    name: json['name'] as String,
    surname: json['surname'] as String,
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
    };
