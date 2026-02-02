import 'package:get_it/get_it.dart';
import '../data/repositories/auth_repository.dart';
import '../data/local/pref/shared_pref.dart';
import '../data/network/services/google_sign_in_service.dart';
import '../data/network/services/supabase_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Initialize SharedPreferences
  await SharedPref.instance;

  // Register Services
  getIt.registerLazySingleton<GoogleSignInService>(() => GoogleSignInService());
  getIt.registerLazySingleton<SupabaseService>(() => SupabaseService());

  // Register Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      googleSignInService: getIt<GoogleSignInService>(),
      supabaseService: getIt<SupabaseService>(),
    ),
  );

  // Add more repositories here as needed
}
