import 'dart:convert';

class Dob {
  final DateTime date;
  final int age;

  Dob({required this.date, required this.age});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'date': date.millisecondsSinceEpoch, 'age': age};
  }

  factory Dob.fromMap(Map<String, dynamic> map) {
    return Dob(
      date: DateTime.parse(map['date'] as String),
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dob.fromJson(String source) =>
      Dob.fromMap(json.decode(source) as Map<String, dynamic>);
}
