
class DatabaseException implements Exception {
  final String message;

  DatabaseException([this.message = 'Erreur de base de données.']);

  @override
  String toString() => 'DatabaseException: $message';
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Erreur de cache.']);

  @override
  String toString() => 'CacheException: $message';
}

class UnexpectedException implements Exception {
  final String message;

  UnexpectedException([this.message = 'Une erreur inattendue est survenue.']);

  @override
  String toString() => 'UnexpectedException: $message';
}
