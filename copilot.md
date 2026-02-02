# GitHub Copilot Instructions for VangLai App

## Project Context

VangLai is a Flutter tennis court booking application built with **Clean Architecture**, **BLoC pattern**, and **go_router** for navigation. This document provides guidance for GitHub Copilot when assisting with this project.

## Architecture Guidelines

### Project Structure
- Follow **Clean Architecture** principles with three main layers:
  - **Common Layer**: Shared utilities, constants, themes, and extensions
  - **Data Layer**: Models, repositories, network services, and local storage
  - **Presentation Layer**: UI screens, state management (BLoC/Cubit), and widgets

### File Organization
- Place files in their appropriate layer directories
- One class per file
- Use snake_case for file names: `login_page.dart`, `auth_repository.dart`
- Match file names with class names (lowercase with underscores)

## Code Standards

### Naming Conventions
```dart
// Classes and Types: PascalCase
class LoginCubit extends Cubit<LoginState> {}
class UserRepository {}

// Variables and Functions: camelCase
final emailController = TextEditingController();
void handleLogin() {}

// Constants: lowerCamelCase or UPPER_CASE
const String baseUrl = 'https://api.example.com';
static const String API_KEY = 'your-key';

// Private members: prefix with underscore
final _privateVariable = '';
void _privateMethod() {}
```

### Import Order
1. Dart/Flutter core libraries
2. Third-party packages
3. Project imports (common, data, presentation)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../common/theme/app_colors.dart';
import '../../../data/repositories/auth_repository.dart';
```

## State Management with BLoC

### Creating a New Feature with BLoC

1. **Create State File** (`feature_state.dart`):
```dart
import 'package:equatable/equatable.dart';

abstract class FeatureState extends Equatable {
  const FeatureState();
  
  @override
  List<Object?> get props => [];
}

class FeatureInitial extends FeatureState {}

class FeatureLoading extends FeatureState {}

class FeatureSuccess extends FeatureState {
  final DataModel data;
  
  const FeatureSuccess(this.data);
  
  @override
  List<Object?> get props => [data];
}

class FeatureError extends FeatureState {
  final String message;
  
  const FeatureError(this.message);
  
  @override
  List<Object?> get props => [message];
}
```

2. **Create Cubit File** (`feature_cubit.dart`):
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/feature_repository.dart';
import '../../../common/exceptions/app_exception.dart';
import 'feature_state.dart';

class FeatureCubit extends Cubit<FeatureState> {
  final FeatureRepository _repository;

  FeatureCubit(this._repository) : super(FeatureInitial());

  Future<void> loadData() async {
    emit(FeatureLoading());
    try {
      final data = await _repository.getData();
      emit(FeatureSuccess(data));
    } on AppException catch (e) {
      emit(FeatureError(e.message));
    } catch (e) {
      emit(FeatureError('An unexpected error occurred'));
    }
  }
}
```

3. **Use in Widget**:
```dart
BlocProvider(
  create: (context) => FeatureCubit(getIt()),
  child: BlocConsumer<FeatureCubit, FeatureState>(
    listener: (context, state) {
      if (state is FeatureError) {
        showSnackBar(state.message, isError: true);
      }
    },
    builder: (context, state) {
      if (state is FeatureLoading) {
        return const LoadingWidget();
      }
      // ... build UI
    },
  ),
)
```

## Navigation with go_router

### Adding New Routes

1. **Define route path in** `app_routes.dart`:
```dart
static const String newFeature = '/new-feature';
```

2. **Add GoRoute**:
```dart
GoRoute(
  path: newFeature,
  name: 'newFeature',
  builder: (context, state) => const NewFeaturePage(),
),
```

3. **Navigate**:
```dart
// Push new route
context.go(AppRoutes.newFeature);

// Push with replacement
context.go(AppRoutes.newFeature);

// Pop
context.pop();

// With parameters
context.go('/profile/${userId}');
```

## Data Layer Patterns

### Creating a Repository
```dart
class FeatureRepository {
  final DioClient _dioClient = DioClient.instance;

  Future<DataModel> getData() async {
    try {
      final response = await _dioClient.get(ApiConstants.endpoint);
      final baseResponse = BaseResponse.fromJson(
        response.data,
        (data) => DataModel.fromJson(data),
      );

      if (baseResponse.success && baseResponse.data != null) {
        return baseResponse.data!;
      } else {
        throw ServerException(
          message: baseResponse.error ?? 'Failed to fetch data',
        );
      }
    } on DioException catch (e) {
      throw NetworkException(
        message: e.message ?? 'Network error occurred',
        code: e.response?.statusCode.toString(),
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
```

### Creating Models
```dart
class DataModel {
  final String id;
  final String name;
  final DateTime? createdAt;

  DataModel({
    required this.id,
    required this.name,
    this.createdAt,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  DataModel copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
  }) {
    return DataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
```

## UI/UX Guidelines

### Using Theme
```dart
// Colors
color: AppColors.primary,
backgroundColor: AppColors.background,

// Text Styles
style: AppTextStyles.headlineMedium,
style: Theme.of(context).textTheme.titleLarge,
```

### Common Widgets Pattern
```dart
// Loading
if (state is Loading) return const LoadingWidget();

// Error
if (state is Error) return ErrorWidget(
  message: state.message,
  onRetry: () => cubit.retry(),
);

// Empty
if (items.isEmpty) return const EmptyWidget(
  message: 'No items found',
);
```

### BaseState Usage
```dart
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends BaseState<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: /* ... */,
    );
  }
  
  // Use built-in methods
  void handleError() {
    showSnackBar('Error message', isError: true);
  }
  
  void updateUI() {
    safeSetState(() {
      // Update state safely
    });
  }
}
```

## Dependency Injection

### Registering Services
In `lib/di/service_locator.dart`:
```dart
Future<void> setupServiceLocator() async {
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<FeatureRepository>(() => FeatureRepository());
  
  // Services
  getIt.registerLazySingleton<ApiService>(() => ApiService());
}
```

### Using Services
```dart
// In widgets
BlocProvider(
  create: (context) => FeatureCubit(getIt()),
  child: /* ... */,
)

// Directly
final repository = getIt<AuthRepository>();
```

## Testing Guidelines

### Unit Test Structure
```dart
void main() {
  group('FeatureCubit', () {
    late FeatureCubit cubit;
    late MockRepository repository;

    setUp(() {
      repository = MockRepository();
      cubit = FeatureCubit(repository);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is FeatureInitial', () {
      expect(cubit.state, isA<FeatureInitial>());
    });

    blocTest<FeatureCubit, FeatureState>(
      'emits [Loading, Success] when data loads successfully',
      build: () => cubit,
      act: (cubit) => cubit.loadData(),
      expect: () => [
        isA<FeatureLoading>(),
        isA<FeatureSuccess>(),
      ],
    );
  });
}
```

## Common Tasks

### Adding a New Page
1. Create page file in `lib/presentation/pages/feature_name/`
2. Create cubit/state if needed in `lib/presentation/cubits/feature_name/`
3. Add route in `lib/routes/app_routes.dart`
4. Register dependencies in `lib/di/service_locator.dart`

### Adding API Endpoint
1. Add constant in `lib/data/network/constants/api_constants.dart`
2. Create/update repository in `lib/data/repositories/`
3. Create request/response models in `lib/data/model/`

### Adding New Theme Color
1. Add color in `lib/common/theme/app_colors.dart`
2. Use in widgets: `AppColors.yourNewColor`

## Error Handling

### Always use try-catch in repositories:
```dart
try {
  // API call
} on DioException catch (e) {
  throw NetworkException(message: e.message ?? 'Network error');
} on AppException {
  rethrow;
} catch (e) {
  throw AppException(message: e.toString());
}
```

### Display errors to users:
```dart
if (state is FeatureError) {
  showSnackBar(state.message, isError: true);
}
```

## Performance Tips

- Use `const` constructors when possible
- Implement `Equatable` for state classes
- Avoid rebuilding entire widget tree
- Use `ListView.builder` for long lists
- Dispose controllers in `dispose()` method

## Security

- Never commit API keys or secrets
- Use environment variables for sensitive data
- Validate all user inputs
- Use HTTPS for all network calls

## Comments and Documentation

```dart
/// A comprehensive description of what this class does.
/// 
/// Longer description with examples if needed.
class MyClass {
  /// Description of this method.
  /// 
  /// [param1] - what this parameter does
  /// Returns: what this method returns
  String myMethod(String param1) {
    // Implementation comment for complex logic
    return result;
  }
}
```

---

**Remember**: When generating code, always follow these patterns and conventions to maintain consistency across the VangLai app codebase.
