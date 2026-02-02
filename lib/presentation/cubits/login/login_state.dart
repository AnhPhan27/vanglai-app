import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../data/model/response/user.dart';

enum AuthProvider { email, google }

/// Sealed class cho Login States
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

/// Initial state - chưa thực hiện hành động gì
class LoginInitial extends LoginState {
  const LoginInitial();
}

/// Loading state - đang xử lý đăng nhập
class LoginLoading extends LoginState {
  final AuthProvider? provider;

  const LoginLoading({this.provider});

  @override
  List<Object?> get props => [provider];
}

/// Success state - đăng nhập thành công
class LoginSuccess extends LoginState {
  final supabase.User supabaseUser;
  final User? appUser; // Nullable vì có thể chưa có trong database
  final AuthProvider provider;

  const LoginSuccess({
    required this.supabaseUser,
    this.appUser,
    required this.provider,
  });

  @override
  List<Object?> get props => [supabaseUser, appUser, provider];
}

/// Error state - có lỗi xảy ra
class LoginError extends LoginState {
  final String message;
  final String? code;
  final AuthProvider? provider;

  const LoginError({required this.message, this.code, this.provider});

  @override
  List<Object?> get props => [message, code, provider];
}
