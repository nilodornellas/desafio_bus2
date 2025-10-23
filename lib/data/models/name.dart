import 'dart:convert';

class Name {
  final String title;
  final String first;
  final String last;

  Name({required this.title, required this.first, required this.last});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'first': first, 'last': last};
  }

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      title: map['title'] as String,
      first: map['first'] as String,
      last: map['last'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Name.fromJson(String source) =>
      Name.fromMap(json.decode(source) as Map<String, dynamic>);
}
