import 'package:dio/dio.dart';
import '../../local/pref/shared_pref.dart';
import '../../../common/constants/app_constants.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final pref = await SharedPref.instance;
    final token = await pref.getString(AppConstants.keyToken);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Handle unauthorized - refresh token or logout
    }
    handler.next(err);
  }
}
