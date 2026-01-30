import 'package:dio/dio.dart';
import '../../../common/utils/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.i(
      '>>> Request: ${options.method} ${options.uri}\n'
      'Headers: ${options.headers}\n'
      'Body: ${options.data}',
      tag: 'HTTP',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.i(
      '<<< Response: ${response.statusCode} ${response.requestOptions.uri}\n'
      'Data: ${response.data}',
      tag: 'HTTP',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger.e(
      '!!! Error: ${err.requestOptions.method} ${err.requestOptions.uri}\n'
      'Status: ${err.response?.statusCode}\n'
      'Message: ${err.message}\n'
      'Data: ${err.response?.data}',
      tag: 'HTTP',
      error: err,
    );
    handler.next(err);
  }
}
