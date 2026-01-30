import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/model/request/login_request.dart';
import '../../../common/exceptions/app_exception.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final request = LoginRequest(email: email, password: password);
      final user = await _authRepository.login(request);
      emit(LoginSuccess(user));
    } on AppException catch (e) {
      emit(LoginError(e.message));
    } catch (e) {
      emit(LoginError('An unexpected error occurred'));
    }
  }

  void reset() {
    emit(LoginInitial());
  }
}
