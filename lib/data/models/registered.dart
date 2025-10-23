import 'dart:convert';

class Registered {
  final DateTime date;
  final int age;

  Registered({required this.date, required this.age});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'date': date.millisecondsSinceEpoch, 'age': age};
  }

  factory Registered.fromMap(Map<String, dynamic> map) {
    return Registered(
      date: DateTime.parse(map['date'] as String),
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Registered.fromJson(String source) =>
      Registered.fromMap(json.decode(source) as Map<String, dynamic>);
}
