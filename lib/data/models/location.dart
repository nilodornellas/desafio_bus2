import 'dart:convert';

class Location {
  final Street street;
  final String city;
  final String country;
  final int postCode;

  Location({
    required this.street,
    required this.city,
    required this.country,
    required this.postCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': street.toMap(),
      'city': city,
      'country': country,
      'postCode': postCode,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      street: Street.fromMap(map['street'] as Map<String, dynamic>),
      city: map['city'] as String,
      country: map['country'] as String,
      postCode: map['postcode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Street {
  final String name;
  final int number;

  Street({required this.name, required this.number});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'number': number};
  }

  factory Street.fromMap(Map<String, dynamic> map) {
    return Street(name: map['name'] as String, number: map['number'] as int);
  }

  String toJson() => json.encode(toMap());

  factory Street.fromJson(String source) =>
      Street.fromMap(json.decode(source) as Map<String, dynamic>);
}
