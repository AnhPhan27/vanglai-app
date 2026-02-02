import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../common/exceptions/app_exception.dart';

/// Service để xử lý Supabase
/// Quản lý việc khởi tạo, xác thực và các tương tác với Supabase
class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  /// Lấy Supabase client instance
  SupabaseClient get client => Supabase.instance.client;

  /// Khởi tạo Supabase
  /// Gọi hàm này trong main.dart trước khi runApp
  /// [url]: Supabase project URL
  /// [anonKey]: Supabase anonymous key
  static Future<void> initialize({
    required String url,
    required String anonKey,
  }) async {
    try {
      await Supabase.initialize(url: url, anonKey: anonKey);
    } catch (e) {
      throw AppException(
        message: 'Supabase initialization failed: ${e.toString()}',
        code: 'SUPABASE_INIT_ERROR',
      );
    }
  }

  /// Đăng nhập với Google ID Token
  /// [idToken]: Google ID Token nhận được từ GoogleSignInService
  /// [accessToken]: Google Access Token nhận được từ GoogleSignInService
  /// Returns: AuthResponse từ Supabase
  /// Throws: AppException nếu có lỗi
  Future<AuthResponse> signInWithGoogle({
    required String idToken,
    required String accessToken,
  }) async {
    try {
      final response = await client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      return response;
    } catch (e) {
      throw AppException(
        message: 'Supabase Google Sign In failed: ${e.toString()}',
        code: 'SUPABASE_GOOGLE_SIGNIN_ERROR',
      );
    }
  }

  /// Đăng nhập với email và password
  /// [email]: Email của người dùng
  /// [password]: Mật khẩu
  /// Returns: AuthResponse từ Supabase
  /// Throws: AppException nếu có lỗi
  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return response;
    } on AuthException catch (e) {
      throw AppException(
        message: e.message,
        code: e.statusCode ?? 'AUTH_ERROR',
      );
    } catch (e) {
      throw AppException(
        message: 'Sign in failed: ${e.toString()}',
        code: 'SIGNIN_ERROR',
      );
    }
  }

  /// Đăng ký tài khoản mới
  /// [email]: Email của người dùng
  /// [password]: Mật khẩu
  /// [data]: Metadata bổ sung (tùy chọn)
  /// Returns: AuthResponse từ Supabase
  /// Throws: AppException nếu có lỗi
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: data,
      );

      return response;
    } on AuthException catch (e) {
      throw AppException(
        message: e.message,
        code: e.statusCode ?? 'AUTH_ERROR',
      );
    } catch (e) {
      throw AppException(
        message: 'Sign up failed: ${e.toString()}',
        code: 'SIGNUP_ERROR',
      );
    }
  }

  /// Đăng xuất
  /// Throws: AppException nếu có lỗi
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } catch (e) {
      throw AppException(
        message: 'Sign out failed: ${e.toString()}',
        code: 'SIGNOUT_ERROR',
      );
    }
  }

  /// Lấy session hiện tại
  /// Returns: Session nếu người dùng đã đăng nhập, null nếu chưa
  Session? get currentSession => client.auth.currentSession;

  /// Lấy thông tin user hiện tại
  /// Returns: User nếu người dùng đã đăng nhập, null nếu chưa
  User? get currentUser => client.auth.currentUser;

  /// Kiểm tra xem người dùng đã đăng nhập chưa
  bool get isSignedIn => currentUser != null;

  /// Lắng nghe thay đổi auth state
  /// Returns: Stream của AuthState
  Stream<AuthState> get onAuthStateChange => client.auth.onAuthStateChange;

  /// Refresh session hiện tại
  /// Returns: AuthResponse với session mới
  /// Throws: AppException nếu có lỗi
  Future<AuthResponse> refreshSession() async {
    try {
      final response = await client.auth.refreshSession();
      return response;
    } catch (e) {
      throw AppException(
        message: 'Refresh session failed: ${e.toString()}',
        code: 'REFRESH_SESSION_ERROR',
      );
    }
  }

  /// Gửi email reset password
  /// [email]: Email của người dùng
  /// Throws: AppException nếu có lỗi
  Future<void> resetPasswordForEmail(String email) async {
    try {
      await client.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw AppException(
        message: e.message,
        code: e.statusCode ?? 'AUTH_ERROR',
      );
    } catch (e) {
      throw AppException(
        message: 'Reset password failed: ${e.toString()}',
        code: 'RESET_PASSWORD_ERROR',
      );
    }
  }

  /// Cập nhật thông tin user
  /// [data]: Map chứa các thông tin cần cập nhật
  /// Returns: UserResponse với thông tin user đã cập nhật
  /// Throws: AppException nếu có lỗi
  Future<UserResponse> updateUser(UserAttributes data) async {
    try {
      final response = await client.auth.updateUser(data);
      return response;
    } on AuthException catch (e) {
      throw AppException(
        message: e.message,
        code: e.statusCode ?? 'AUTH_ERROR',
      );
    } catch (e) {
      throw AppException(
        message: 'Update user failed: ${e.toString()}',
        code: 'UPDATE_USER_ERROR',
      );
    }
  }
}
