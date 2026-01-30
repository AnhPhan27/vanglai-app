class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  AppException({required this.message, this.code, this.data});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException({required super.message, super.code, super.data});
}

class ServerException extends AppException {
  ServerException({required super.message, super.code, super.data});
}

class CacheException extends AppException {
  CacheException({required super.message, super.code, super.data});
}

class ValidationException extends AppException {
  ValidationException({required super.message, super.code, super.data});
}
