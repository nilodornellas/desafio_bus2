import 'dart:convert';

import 'package:uuid/uuid.dart';

class Id {
  final String? name;
  final String value;

  Id({required this.name, required this.value});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'value': value};
  }

  factory Id.fromMap(Map<String, dynamic> map) {
    final value = map['value'] == null || map['value'] == ''
        ? Uuid().v4()
        : map['value'] as String;
    return Id(name: map['name'] as String?, value: value);
  }

  String toJson() => json.encode(toMap());

  factory Id.fromJson(String source) =>
      Id.fromMap(json.decode(source) as Map<String, dynamic>);
}
