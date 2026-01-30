class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.example.com/api/v1';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile/update';
}
