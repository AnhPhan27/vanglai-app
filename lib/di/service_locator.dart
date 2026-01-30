import 'package:get_it/get_it.dart';
import '../data/repositories/auth_repository.dart';
import '../data/local/pref/shared_pref.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Initialize SharedPreferences
  await SharedPref.instance;

  // Register Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());

  // Add more repositories here as needed
}
