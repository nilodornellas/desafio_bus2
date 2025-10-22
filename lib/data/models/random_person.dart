// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:desafio_bus2/data/enums/gender.dart';
import 'package:desafio_bus2/data/models/location.dart';
import 'package:desafio_bus2/data/models/picture.dart';

class RandomPerson {
  final PersonId id;
  final PersonName name;
  final Location location;
  final String email;
  final Gender gender;
  final String phone;
  final String cell;
  final Picture picture;

  RandomPerson({
    required this.id,
    required this.name,
    required this.location,
    required this.email,
    required this.gender,
    required this.phone,
    required this.cell,
    required this.picture,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toMap(),
      'name': name.toMap(),
      'location': location.toMap(),
      'email': email,
      'gender': gender.name,
      'phone': phone,
      'cell': cell,
      'picture': picture.toMap(),
    };
  }

  factory RandomPerson.fromMap(Map<String, dynamic> map) {
    return RandomPerson(
      id: PersonId.fromMap(map['id'] as Map<String, dynamic>),
      name: PersonName.fromMap(map['name'] as Map<String, dynamic>),
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      email: map['email'] as String,
      gender: Gender.fromJson(map['gender'] as String),
      phone: map['phone'] as String,
      cell: map['cell'] as String,
      picture: Picture.fromMap(map['picture'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory RandomPerson.fromJson(String source) =>
      RandomPerson.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PersonId {
  final String? name;
  final String value;

  PersonId({required this.name, required this.value});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'value': value};
  }

  factory PersonId.fromMap(Map<String, dynamic> map) {
    return PersonId(
      name: map['name'] as String?,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonId.fromJson(String source) =>
      PersonId.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PersonName {
  final String title;
  final String first;
  final String last;

  PersonName({required this.title, required this.first, required this.last});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'first': first, 'last': last};
  }

  factory PersonName.fromMap(Map<String, dynamic> map) {
    return PersonName(
      title: map['title'] as String,
      first: map['first'] as String,
      last: map['last'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonName.fromJson(String source) =>
      PersonName.fromMap(json.decode(source) as Map<String, dynamic>);
}
