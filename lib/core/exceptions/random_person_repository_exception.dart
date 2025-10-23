class RandomPersonRepositoryException implements Exception {
  final String message;
  RandomPersonRepositoryException(this.message);

  @override
  String toString() => 'RandomPersonRepositoryException: $message';
}
