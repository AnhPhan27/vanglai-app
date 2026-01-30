import 'dart:developer' as developer;

class Logger {
  Logger._();

  static void d(String message, {String? tag}) {
    developer.log(message, name: tag ?? 'DEBUG', level: 500);
  }

  static void i(String message, {String? tag}) {
    developer.log(message, name: tag ?? 'INFO', level: 800);
  }

  static void w(String message, {String? tag}) {
    developer.log(message, name: tag ?? 'WARNING', level: 900);
  }

  static void e(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: tag ?? 'ERROR',
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
