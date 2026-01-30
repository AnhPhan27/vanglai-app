import 'package:dio/dio.dart';
import '../network/client/dio_client.dart';
import '../network/constants/api_constants.dart';
import '../model/request/login_request.dart';
import '../model/response/base_response.dart';
import '../model/response/user.dart';
import '../../common/exceptions/app_exception.dart';

class AuthRepository {
  final DioClient _dioClient = DioClient.instance;

  Future<User> login(LoginRequest request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.login,
        data: request.toJson(),
      );

      final baseResponse = BaseResponse.fromJson(
        response.data,
        (data) => User.fromJson(data),
      );

      if (baseResponse.success && baseResponse.data != null) {
        return baseResponse.data!;
      } else {
        throw ServerException(message: baseResponse.error ?? 'Login failed');
      }
    } on DioException catch (e) {
      throw NetworkException(
        message: e.message ?? 'Network error occurred',
        code: e.response?.statusCode.toString(),
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _dioClient.post(ApiConstants.logout);
    } on DioException catch (e) {
      throw NetworkException(
        message: e.message ?? 'Network error occurred',
        code: e.response?.statusCode.toString(),
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
