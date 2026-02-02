import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../base/base_state.dart';
import '../../../routes/app_routes.dart';
import '../../../data/network/services/supabase_service.dart';
import '../../../di/service_locator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Delay một chút để show splash screen
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    try {
      // Kiểm tra auth state từ Supabase
      final supabaseService = getIt<SupabaseService>();
      final isSignedIn = supabaseService.isSignedIn;

      if (isSignedIn) {
        // Đã đăng nhập -> vào Home
        context.go(AppRoutes.home);
      } else {
        // Chưa đăng nhập -> vào Login
        context.go(AppRoutes.login);
      }
    } catch (e) {
      // Nếu có lỗi, vào Login để đăng nhập lại
      if (mounted) {
        context.go(AppRoutes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flutter_dash,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 24),
            Text(
              'Vanglai App',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
