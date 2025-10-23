import 'dart:convert';

import 'package:desafio_bus2/data/enums/gender.dart';
import 'package:desafio_bus2/data/models/location.dart';
import 'package:desafio_bus2/data/models/login.dart';
import 'package:desafio_bus2/data/models/picture.dart';
import 'package:desafio_bus2/data/models/dob.dart';
import 'package:desafio_bus2/data/models/id.dart';
import 'package:desafio_bus2/data/models/name.dart';
import 'package:desafio_bus2/data/models/registered.dart';

class RandomPerson {
  final Id id;
  final Name name;
  final Location location;
  final String email;
  final Gender gender;
  final Login login;
  final Dob dob;
  final Registered registered;
  final String phone;
  final String cell;
  final Picture picture;
  final String nat;

  RandomPerson({
    required this.id,
    required this.name,
    required this.location,
    required this.email,
    required this.gender,
    required this.login,
    required this.dob,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.picture,
    required this.nat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toMap(),
      'name': name.toMap(),
      'location': location.toMap(),
      'email': email,
      'gender': gender.name,
      'login': login.toMap(),
      'dob': dob.toMap(),
      'registered': registered.toMap(),
      'phone': phone,
      'cell': cell,
      'picture': picture.toMap(),
      'nat': nat,
    };
  }

  factory RandomPerson.fromMap(Map<String, dynamic> map) {
    return RandomPerson(
      id: Id.fromMap(map['id'] as Map<String, dynamic>),
      name: Name.fromMap(map['name'] as Map<String, dynamic>),
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      email: map['email'] as String,
      gender: Gender.fromJson(map['gender'] as String),
      login: Login.fromMap(map['login'] as Map<String, dynamic>),
      dob: Dob.fromMap(map['dob'] as Map<String, dynamic>),
      registered: Registered.fromMap(map['registered'] as Map<String, dynamic>),
      phone: map['phone'] as String,
      cell: map['cell'] as String,
      picture: Picture.fromMap(map['picture'] as Map<String, dynamic>),
      nat: map['nat'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RandomPerson.fromJson(String source) =>
      RandomPerson.fromMap(json.decode(source) as Map<String, dynamic>);
}
