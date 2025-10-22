enum Gender {
  male('Masculino'),
  female('Feminino'),
  other('Outro');

  final String label;
  const Gender(this.label);

  static Gender fromJson(String value) {
    switch (value.toLowerCase()) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      case 'other':
        return Gender.other;
      default:
        throw Exception('Gênero inválido: $value');
    }
  }
}
