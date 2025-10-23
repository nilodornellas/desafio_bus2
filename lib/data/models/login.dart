import 'dart:convert';

class Login {
  final String id;
  final String username;
  final String password;
  final String salt;
  final String md5;
  final String sha1;
  final String sha256;

  Login({
    required this.id,
    required this.username,
    required this.password,
    required this.salt,
    required this.md5,
    required this.sha1,
    required this.sha256,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': id,
      'username': username,
      'password': password,
      'salt': salt,
      'md5': md5,
      'sha1': sha1,
      'sha256': sha256,
    };
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(
      id: map['uuid'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      salt: map['salt'] as String,
      md5: map['md5'] as String,
      sha1: map['sha1'] as String,
      sha256: map['sha256'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Login.fromJson(String source) =>
      Login.fromMap(json.decode(source) as Map<String, dynamic>);
}
