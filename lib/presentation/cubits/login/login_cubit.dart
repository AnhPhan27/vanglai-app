import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../common/exceptions/app_exception.dart';
import '../../../common/utils/validators.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginInitial());

  /// Đăng nhập với Google
  Future<void> signInWithGoogle() async {
    emit(const LoginLoading(provider: AuthProvider.google));

    try {
      final supabaseUser = await _authRepository.signInWithGoogle();

      emit(
        LoginSuccess(
          supabaseUser: supabaseUser,
          appUser: null,
          provider: AuthProvider.google,
        ),
      );
    } on GoogleSignInException catch (e) {
      // Xử lý các lỗi Google Sign In
      if (e.code == GoogleSignInExceptionCode.canceled) {
        // Người dùng hủy đăng nhập - quay về trạng thái ban đầu
        emit(const LoginInitial());
      } else {
        emit(
          LoginError(
            message: _getGoogleSignInErrorMessage(e.code),
            code: e.code.toString(),
            provider: AuthProvider.google,
          ),
        );
      }
    } on AppException catch (e) {
      emit(
        LoginError(
          message: _getUserFriendlyMessage(e.message),
          code: e.code,
          provider: AuthProvider.google,
        ),
      );
    } catch (e) {
      emit(
        LoginError(
          message: 'Google Sign In failed. Please try again.',
          code: 'GOOGLE_SIGNIN_ERROR',
          provider: AuthProvider.google,
        ),
      );
    }
  }

  /// Đăng nhập với Email/Password
  Future<void> loginWithEmail(String email, String password) async {
    // Validate input using Validators utility
    final emailError = Validators.validateEmail(email);
    if (emailError != null) {
      emit(
        LoginError(
          message: emailError,
          code: 'INVALID_EMAIL',
          provider: AuthProvider.email,
        ),
      );
      return;
    }

    final passwordError = Validators.validatePassword(password);
    if (passwordError != null) {
      emit(
        LoginError(
          message: passwordError,
          code: 'INVALID_PASSWORD',
          provider: AuthProvider.email,
        ),
      );
      return;
    }

    emit(const LoginLoading(provider: AuthProvider.email));

    try {
      final supabaseUser = await _authRepository.signInWithEmailPassword(
        email: email.trim(),
        password: password,
      );

      emit(
        LoginSuccess(
          supabaseUser: supabaseUser,
          appUser: null,
          provider: AuthProvider.email,
        ),
      );
    } on AppException catch (e) {
      emit(
        LoginError(
          message: _getUserFriendlyMessage(e.message),
          code: e.code,
          provider: AuthProvider.email,
        ),
      );
    } catch (e) {
      emit(
        LoginError(
          message: 'Sign in failed. Please try again.',
          code: 'SIGNIN_ERROR',
          provider: AuthProvider.email,
        ),
      );
    }
  }

  /// Reset về trạng thái ban đầu
  void reset() {
    emit(const LoginInitial());
  }

  // ========== Helper Methods ==========

  String _getUserFriendlyMessage(String message) {
    // Convert technical error messages to user-friendly ones
    if (message.contains('Invalid login credentials')) {
      return 'Invalid email or password';
    }
    if (message.contains('Email not confirmed')) {
      return 'Please verify your email before signing in';
    }
    if (message.contains('User not found')) {
      return 'No account found with this email';
    }
    if (message.contains('Too many requests')) {
      return 'Too many login attempts. Please try again later';
    }
    // Google Sign In specific errors
    if (message.contains('No Google accounts found') ||
        message.contains('no account') ||
        message.toLowerCase().contains('add account')) {
      return 'No Google account found on this device. Please add a Google account in Settings first.';
    }
    if (message.contains('network_error') ||
        message.contains('Network error')) {
      return 'Network error. Please check your internet connection and try again.';
    }
    return message;
  }

  String _getGoogleSignInErrorMessage(GoogleSignInExceptionCode code) {
    switch (code) {
      case GoogleSignInExceptionCode.canceled:
        return 'Sign in cancelled';
      case GoogleSignInExceptionCode.unknownError:
        return 'An unknown error occurred. Please try again';
      default:
        return 'Google Sign In failed';
    }
  }
}
