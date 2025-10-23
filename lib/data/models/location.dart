import 'dart:convert';

class Location {
  final Street street;
  final String city;
  final String country;
  final int postCode;
  final Coordinate coordinates;
  final Timezone timezone;

  Location({
    required this.street,
    required this.city,
    required this.country,
    required this.postCode,
    required this.coordinates,
    required this.timezone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': street.toMap(),
      'city': city,
      'country': country,
      'postCode': postCode,
      'coordinates': coordinates.toMap(),
      'timezone': timezone.toMap(),
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      street: Street.fromMap(map['street'] as Map<String, dynamic>),
      city: map['city'] as String,
      country: map['country'] as String,
      postCode: map['postcode'] as int,
      coordinates: Coordinate.fromMap(
        map['coordinates'] as Map<String, dynamic>,
      ),
      timezone: Timezone.fromMap(map['timezone'] as Map<String, dynamic>),
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

class Coordinate {
  final double latitude;
  final double longitude;

  Coordinate({required this.latitude, required this.longitude});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'latitude': latitude, 'longitude': longitude};
  }

  factory Coordinate.fromMap(Map<String, dynamic> map) {
    return Coordinate(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coordinate.fromJson(String source) =>
      Coordinate.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Timezone {
  final String offset;
  final String description;

  Timezone({required this.offset, required this.description});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'offset': offset, 'description': description};
  }

  factory Timezone.fromMap(Map<String, dynamic> map) {
    return Timezone(
      offset: map['offset'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Timezone.fromJson(String source) =>
      Timezone.fromMap(json.decode(source) as Map<String, dynamic>);
}
