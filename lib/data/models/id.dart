import 'dart:convert';

class Id {
  final String? name;
  final String value;

  Id({required this.name, required this.value});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'value': value};
  }

  factory Id.fromMap(Map<String, dynamic> map) {
    return Id(name: map['name'] as String?, value: map['value'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Id.fromJson(String source) =>
      Id.fromMap(json.decode(source) as Map<String, dynamic>);
}
