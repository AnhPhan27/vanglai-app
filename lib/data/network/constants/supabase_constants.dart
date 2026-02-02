class SupabaseConstants {
  SupabaseConstants._();

  /// Supabase Project URL
  /// Lấy từ: Supabase Dashboard > Settings > API > Project URL
  static const String projectUrl = 'https://xcnklcdjhlhjbytcnpgb.supabase.co';

  /// Supabase Anonymous Key
  /// Lấy từ: Supabase Dashboard > Settings > API > Project API keys > anon public
  static const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhjbmtsY2RqaGxoamJ5dGNucGdiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njk3MjU5NTEsImV4cCI6MjA4NTMwMTk1MX0.C89AUNwfFGqQpFsa6slq4kmUpCWefaP6LPwlZZeTO7Y';

  /// Redirect URL cho OAuth (nếu cần)
  static const String redirectUrl = 'YOUR_REDIRECT_URL';

  /// Google Web Client ID (Server Client ID)
  /// Lấy từ: Google Cloud Console > APIs & Services > Credentials > Web Client
  /// Sử dụng cho Android Google Sign In với Supabase
  static const String googleWebClientId =
      '602245371342-18eiihs20iqmdg0prq4rr6d9qu47qglp.apps.googleusercontent.com';

  /// Google iOS Client ID
  /// Lấy từ: Google Cloud Console > APIs & Services > Credentials > iOS Client
  static const String googleIosClientId =
      '602245371342-4fapjos5ob0iqj8t9078li0t93tl2cqr.apps.googleusercontent.com';
}
