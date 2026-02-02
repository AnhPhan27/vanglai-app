import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:google_sign_in/google_sign_in.dart';
import '../network/services/google_sign_in_service.dart';
import '../network/services/supabase_service.dart';

import '../../common/exceptions/app_exception.dart';

class AuthRepository {
  final GoogleSignInService _googleSignInService;
  final SupabaseService _supabaseService;

  AuthRepository({
    GoogleSignInService? googleSignInService,
    SupabaseService? supabaseService,
  }) : _googleSignInService = googleSignInService ?? GoogleSignInService(),
       _supabaseService = supabaseService ?? SupabaseService();

  /// Đăng nhập với Google và Supabase
  /// Returns: Supabase User nếu thành công
  /// Throws: AppException nếu có lỗi
  Future<supabase.User> signInWithGoogle() async {
    try {
      // Bước 1: Đăng nhập với Google
      final googleAccount = await _googleSignInService.signIn();
      if (googleAccount == null) {
        throw AppException(
          message: 'Google Sign In cancelled',
          code: 'GOOGLE_SIGNIN_CANCELLED',
        );
      }

      // Bước 2: Lấy Google tokens
      final idToken = await _googleSignInService.getIdToken();
      final accessToken = await _googleSignInService.getAccessToken();

      // Bước 3: Đăng nhập với Supabase sử dụng Google tokens
      final authResponse = await _supabaseService.signInWithGoogle(
        idToken: idToken,
        accessToken: accessToken,
      );

      if (authResponse.user == null) {
        throw AppException(
          message: 'Failed to get user from Supabase',
          code: 'SUPABASE_NO_USER',
        );
      }

      return authResponse.user!;
    } on GoogleSignInException {
      // Throw lại GoogleSignInException nguyên bản để LoginCubit xử lý
      await _googleSignInService.signOut();
      rethrow;
    } catch (e) {
      // Đảm bảo đăng xuất khỏi Google nếu có lỗi
      await _googleSignInService.signOut();

      if (e is AppException) {
        rethrow;
      }
      throw AppException(
        message: 'Google Sign In failed: ${e.toString()}',
        code: 'GOOGLE_SIGNIN_ERROR',
      );
    }
  }

  /// Đăng nhập với email và password qua Supabase
  /// [email]: Email của người dùng
  /// [password]: Mật khẩu
  /// Returns: Supabase User nếu thành công
  /// Throws: AppException nếu có lỗi
  Future<supabase.User> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await _supabaseService.signInWithPassword(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        throw AppException(
          message: 'Failed to get user from Supabase',
          code: 'SUPABASE_NO_USER',
        );
      }

      return authResponse.user!;
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw AppException(
        message: 'Email Sign In failed: ${e.toString()}',
        code: 'EMAIL_SIGNIN_ERROR',
      );
    }
  }

  /// Đăng ký tài khoản mới
  /// [email]: Email của người dùng
  /// [password]: Mật khẩu
  /// [data]: Metadata bổ sung (tùy chọn)
  /// Returns: Supabase User nếu thành công
  /// Throws: AppException nếu có lỗi
  Future<supabase.User?> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    try {
      final authResponse = await _supabaseService.signUp(
        email: email,
        password: password,
        data: data,
      );

      return authResponse.user;
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw AppException(
        message: 'Sign Up failed: ${e.toString()}',
        code: 'SIGNUP_ERROR',
      );
    }
  }

  /// Đăng xuất khỏi cả Google và Supabase
  Future<void> signOut() async {
    try {
      // Đăng xuất khỏi Supabase
      await _supabaseService.signOut();

      // Đăng xuất khỏi Google
      await _googleSignInService.signOut();
    } catch (e) {
      throw AppException(
        message: 'Sign Out failed: ${e.toString()}',
        code: 'SIGNOUT_ERROR',
      );
    }
  }

  /// Kiểm tra xem người dùng đã đăng nhập chưa
  bool get isSignedIn => _supabaseService.isSignedIn;

  /// Lấy thông tin user hiện tại từ Supabase
  supabase.User? get currentUser => _supabaseService.currentUser;

  /// Lấy session hiện tại từ Supabase
  supabase.Session? get currentSession => _supabaseService.currentSession;

  /// Lắng nghe thay đổi auth state
  Stream<supabase.AuthState> get onAuthStateChange =>
      _supabaseService.onAuthStateChange;

  /// Gửi email reset password
  /// [email]: Email của người dùng
  Future<void> resetPasswordForEmail(String email) async {
    try {
      await _supabaseService.resetPasswordForEmail(email);
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw AppException(
        message: 'Reset password failed: ${e.toString()}',
        code: 'RESET_PASSWORD_ERROR',
      );
    }
  }
}
