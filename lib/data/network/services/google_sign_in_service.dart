import 'package:google_sign_in/google_sign_in.dart';
import '../../../common/exceptions/app_exception.dart';

/// Service để xử lý Google Sign In
/// Quản lý việc đăng nhập, đăng xuất và lấy thông tin người dùng từ Google
class GoogleSignInService {
  static final GoogleSignInService _instance = GoogleSignInService._internal();
  factory GoogleSignInService() => _instance;
  GoogleSignInService._internal();

  /// GoogleSignIn instance
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  /// Biến lưu user hiện tại
  GoogleSignInAccount? _currentUser;

  /// Khởi tạo GoogleSignIn với scopes
  /// Gọi hàm này trước khi sử dụng service
  /// [serverClientId] - Web Client ID từ Google Cloud Console (bắt buộc cho Android)
  Future<void> initialize({
    List<String>? scopes,
    String? serverClientId,
  }) async {
    try {
      await _googleSignIn.initialize(serverClientId: serverClientId);

      // Lắng nghe authentication events
      _googleSignIn.authenticationEvents.listen((event) {
        if (event is GoogleSignInAuthenticationEventSignIn) {
          _currentUser = event.user;
        } else if (event is GoogleSignInAuthenticationEventSignOut) {
          _currentUser = null;
        }
      });
    } catch (e) {
      throw AppException(
        message: 'GoogleSignIn initialization failed: ${e.toString()}',
        code: 'GOOGLE_SIGNIN_INIT_ERROR',
      );
    }
  }

  /// Lấy instance của GoogleSignIn
  GoogleSignIn get googleSignIn => _googleSignIn;

  /// Đăng nhập với Google
  /// Returns: GoogleSignInAccount nếu thành công
  /// Throws: AppException nếu có lỗi
  Future<GoogleSignInAccount?> signIn({List<String>? scopeHint}) async {
    try {
      // Thực hiện đăng nhập
      final account = await _googleSignIn.authenticate(
        scopeHint: scopeHint ?? ['email', 'profile'],
      );

      _currentUser = account;
      return account;
    } catch (e) {
      throw AppException(
        message: 'Google Sign In failed: ${e.toString()}',
        code: 'GOOGLE_SIGN_IN_ERROR',
      );
    }
  }

  /// Đăng nhập im lặng (silent sign in)
  /// Sử dụng khi muốn tự động đăng nhập nếu người dùng đã đăng nhập trước đó
  /// Returns: GoogleSignInAccount nếu thành công, null nếu chưa đăng nhập
  Future<GoogleSignInAccount?> signInSilently() async {
    try {
      final future = _googleSignIn.attemptLightweightAuthentication();
      if (future == null) {
        // Platform không hỗ trợ lightweight authentication
        return null;
      }

      final account = await future;
      _currentUser = account;
      return account;
    } catch (e) {
      // Silent sign in thất bại là bình thường, không throw exception
      return null;
    }
  }

  /// Đăng xuất khỏi Google
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      _currentUser = null;
    } catch (e) {
      throw AppException(
        message: 'Google Sign Out failed: ${e.toString()}',
        code: 'GOOGLE_SIGN_OUT_ERROR',
      );
    }
  }

  /// Ngắt kết nối hoàn toàn khỏi Google
  /// Khác với signOut, disconnect sẽ thu hồi quyền truy cập của ứng dụng
  Future<void> disconnect() async {
    try {
      await _googleSignIn.disconnect();
      _currentUser = null;
    } catch (e) {
      throw AppException(
        message: 'Google Disconnect failed: ${e.toString()}',
        code: 'GOOGLE_DISCONNECT_ERROR',
      );
    }
  }

  /// Lấy Google ID Token
  /// Token này sẽ được sử dụng để xác thực với Supabase
  /// Returns: ID Token string
  /// Throws: AppException nếu có lỗi hoặc chưa đăng nhập
  Future<String> getIdToken() async {
    try {
      if (_currentUser == null) {
        throw AppException(
          message: 'No user signed in',
          code: 'NO_USER_SIGNED_IN',
        );
      }

      final authentication = _currentUser!.authentication;
      final idToken = authentication.idToken;

      if (idToken == null) {
        throw AppException(
          message: 'Failed to get ID token',
          code: 'NO_ID_TOKEN',
        );
      }

      return idToken;
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw AppException(
        message: 'Get ID Token failed: ${e.toString()}',
        code: 'GET_ID_TOKEN_ERROR',
      );
    }
  }

  /// Lấy Google Access Token
  /// Returns: Access Token string
  /// Throws: AppException nếu có lỗi hoặc chưa đăng nhập
  Future<String> getAccessToken() async {
    try {
      if (_currentUser == null) {
        throw AppException(
          message: 'No user signed in',
          code: 'NO_USER_SIGNED_IN',
        );
      }

      // Sử dụng authorization client để lấy access token
      final authClient = _currentUser!.authorizationClient;

      // Request authorization với scopes (email và profile)
      final authorization = await authClient.authorizationForScopes([
        'email',
        'profile',
      ]);

      if (authorization == null) {
        throw AppException(
          message: 'Failed to get access token',
          code: 'NO_ACCESS_TOKEN',
        );
      }

      return authorization.accessToken;
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw AppException(
        message: 'Get Access Token failed: ${e.toString()}',
        code: 'GET_ACCESS_TOKEN_ERROR',
      );
    }
  }

  /// Kiểm tra xem người dùng đã đăng nhập chưa
  bool get isSignedIn => _currentUser != null;

  /// Lấy thông tin người dùng hiện tại
  GoogleSignInAccount? get currentUser => _currentUser;
}
