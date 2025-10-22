// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:desafio_bus2/data/enums/gender.dart';
import 'package:desafio_bus2/data/models/location.dart';
import 'package:desafio_bus2/data/models/picture.dart';

class RandomPerson {
  final String id;
  final String firstName;
  final String lastName;
  final Location location;
  final String email;
  final Gender gender;
  final String phone;
  final String cell;
  final Picture picture;

  RandomPerson({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.email,
    required this.gender,
    required this.phone,
    required this.cell,
    required this.picture,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
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
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
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
