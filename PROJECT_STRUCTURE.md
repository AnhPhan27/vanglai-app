# Vanglai App

A Flutter application with clean architecture, similar to pediasure-plate-tool structure.

## Project Structure

```
lib/
├── common/                    # Common utilities and shared code
│   ├── constants/             # App-wide constants
│   │   ├── app_constants.dart
│   │   └── asset_constants.dart
│   ├── enums/                 # Enumerations
│   │   └── app_enums.dart
│   ├── exceptions/            # Custom exception classes
│   │   └── app_exception.dart
│   ├── mixins/                # Reusable mixins
│   │   └── loading_mixin.dart
│   ├── theme/                 # App theming
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart
│   └── utils/                 # Utility classes
│       ├── extensions.dart
│       ├── logger.dart
│       └── validators.dart
│
├── data/                      # Data layer
│   ├── events/                # Event bus events
│   ├── local/                 # Local data sources
│   │   ├── db/                # Database
│   │   └── pref/              # Shared preferences
│   │       └── shared_pref.dart
│   ├── model/                 # Data models
│   │   ├── request/           # API request models
│   │   │   └── login_request.dart
│   │   └── response/          # API response models
│   │       ├── base_response.dart
│   │       └── user.dart
│   ├── network/               # Network layer
│   │   ├── client/            # HTTP clients
│   │   │   └── dio_client.dart
│   │   ├── constants/         # API constants
│   │   │   └── api_constants.dart
│   │   ├── interceptors/      # HTTP interceptors
│   │   │   ├── auth_interceptor.dart
│   │   │   └── logging_interceptor.dart
│   │   └── services/          # API services
│   └── repositories/          # Repository pattern implementations
│       └── auth_repository.dart
│
├── di/                        # Dependency injection
│   └── service_locator.dart   # GetIt service locator setup
│
├── gen/                       # Generated files (assets, localization, etc.)
│
├── presentation/              # Presentation layer
│   ├── base/                  # Base classes for UI
│   │   └── base_state.dart
│   ├── cubits/                # BLoC/Cubit state management
│   │   └── login/
│   │       ├── login_cubit.dart
│   │       └── login_state.dart
│   ├── pages/                 # Screen pages
│   │   ├── home/
│   │   │   └── home_page.dart
│   │   ├── login/
│   │   │   └── login_page.dart
│   │   └── splash/
│   │       └── splash_page.dart
│   └── widgets/               # Reusable widgets
│       └── common_widgets.dart
│
├── routes/                    # App routing
│   └── app_routes.dart
│
└── main.dart                  # App entry point
```

## Architecture

This project follows **Clean Architecture** principles with three main layers:

### 1. Common Layer
- Shared utilities, constants, themes, and extensions
- Used across all layers

### 2. Data Layer
- **Models**: Request and response DTOs
- **Network**: API clients, interceptors, and services
- **Local**: SharedPreferences and database handling
- **Repositories**: Data source implementations

### 3. Presentation Layer
- **Pages**: UI screens
- **Cubits**: State management using BLoC pattern
- **Widgets**: Reusable UI components
- **Base**: Base classes for screens and widgets

## Key Features

- ✅ Clean Architecture
- ✅ BLoC Pattern for state management
- ✅ Dependency Injection with GetIt
- ✅ Network layer with Dio
- ✅ Local storage with SharedPreferences
- ✅ Custom theme system
- ✅ Centralized routing
- ✅ Error handling
- ✅ Custom validators and extensions

## Dependencies

```yaml
# State Management
flutter_bloc: ^8.1.6
equatable: ^2.0.5

# Dependency Injection
get_it: ^8.0.2

# Network
dio: ^5.7.0

# Local Storage
shared_preferences: ^2.3.3

# Utils
intl: ^0.19.0
```

## Getting Started

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run the app:**
   ```bash
   flutter run
   ```

3. **Build for production:**
   ```bash
   flutter build apk --release  # For Android
   flutter build ios --release  # For iOS
   ```

## Usage Guide

### Adding a new feature

1. **Create models** in `lib/data/model/`
2. **Create repository** in `lib/data/repositories/`
3. **Create cubit/state** in `lib/presentation/cubits/`
4. **Create page** in `lib/presentation/pages/`
5. **Register dependencies** in `lib/di/service_locator.dart`
6. **Add route** in `lib/routes/app_routes.dart`

### Example: Login Flow

```dart
// 1. Model (lib/data/model/request/login_request.dart)
class LoginRequest {
  final String email;
  final String password;
  
  LoginRequest({required this.email, required this.password});
  
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

// 2. Repository (lib/data/repositories/auth_repository.dart)
class AuthRepository {
  Future<User> login(LoginRequest request) async {
    // API call implementation
  }
}

// 3. Cubit (lib/presentation/cubits/login/login_cubit.dart)
class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  
  Future<void> login(String email, String password) async {
    // Business logic
  }
}

// 4. Page (lib/presentation/pages/login/login_page.dart)
class LoginPage extends StatefulWidget {
  // UI implementation with BlocConsumer
}
```

## Project Conventions

### File Naming
- Use snake_case for file names: `login_page.dart`, `auth_repository.dart`
- Match file name with class name

### Code Organization
- One class per file
- Group related files in folders
- Keep files under 300 lines when possible

### State Management
- Use Cubit for simple state
- Use Bloc for complex state with events
- Always use Equatable for states

## License

This project is private and proprietary.
