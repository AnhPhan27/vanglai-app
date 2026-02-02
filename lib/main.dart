import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'di/service_locator.dart';
import 'routes/app_routes.dart';
import 'common/theme/app_theme.dart';
import 'common/constants/app_constants.dart';
import 'data/network/services/supabase_service.dart';
import 'data/network/services/google_sign_in_service.dart';
import 'data/network/constants/supabase_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Supabase
  await SupabaseService.initialize(
    url: SupabaseConstants.projectUrl,
    anonKey: SupabaseConstants.anonKey,
  );

  // Setup dependency injection
  await setupServiceLocator();

  // Khởi tạo Google Sign In với Web Client ID (serverClientId cho Android)
  await getIt<GoogleSignInService>().initialize(
    serverClientId: SupabaseConstants.googleWebClientId,
  );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: AppRoutes.router,
    );
  }
}
