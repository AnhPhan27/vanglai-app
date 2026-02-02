# VangLai App 🎾

A modern Flutter application for tennis court booking and community management with clean architecture and beautiful UI.

![Flutter Version](https://img.shields.io/badge/Flutter-3.10.1-blue.svg)
![Dart Version](https://img.shields.io/badge/Dart-3.10.1-blue.svg)
![License](https://img.shields.io/badge/License-Private-red.svg)

## 📱 About

VangLai is a tennis court booking platform that connects players with available courts. The app features:

- 🎯 Court discovery and booking
- 👥 Community features for tennis players
- 📍 Location-based court search
- 🔐 Google Sign-In authentication
- 🌓 Light/Dark theme support

## ✨ Features

- **Modern UI/UX**: Beautiful, responsive design with blur effects and gradient overlays
- **Clean Architecture**: Separation of concerns with data, domain, and presentation layers
- **State Management**: BLoC pattern for predictable state management
- **Routing**: go_router for type-safe, declarative navigation
- **Network Layer**: Dio with interceptors for API calls
- **Local Storage**: SharedPreferences for persistent data
- **Dependency Injection**: GetIt for service locator pattern

## 🏗️ Architecture

```
lib/
├── common/              # Shared utilities and resources
│   ├── constants/       # App constants
│   ├── enums/          # Enumerations
│   ├── exceptions/     # Custom exceptions
│   ├── mixins/         # Reusable mixins
│   ├── theme/          # App theming
│   └── utils/          # Utility functions
├── data/               # Data layer
│   ├── local/          # Local storage
│   ├── model/          # Data models
│   ├── network/        # API services
│   └── repositories/   # Repository implementations
├── di/                 # Dependency injection
├── presentation/       # UI layer
│   ├── base/          # Base classes
│   ├── cubits/        # BLoC/Cubit state management
│   ├── pages/         # Screen pages
│   └── widgets/       # Reusable widgets
└── routes/            # App routing
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.10.1 or higher)
- Dart SDK (3.10.1 or higher)
- Android Studio / VS Code
- iOS development tools (for macOS)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/AnhPhan27/vanglai-app.git
   cd vanglai_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

**Android:**
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

## 📦 Dependencies

### Core
- **flutter_bloc** (^8.1.6) - State management
- **equatable** (^2.0.5) - Value equality
- **go_router** (^14.6.2) - Routing solution

### Network & Storage
- **dio** (^5.7.0) - HTTP client
- **shared_preferences** (^2.3.3) - Local storage

### DI & Utils
- **get_it** (^8.0.2) - Service locator
- **intl** (^0.19.0) - Internationalization

## 🎨 Design System

### Colors
- **Primary**: `#f48c25` (Orange)
- **Emerald**: `#10b981` (Green accent)
- **Dark Background**: `#221910`
- **Light Background**: `#f8f7f5`

### Typography
- **Display Font**: Lexend
- **Body Font**: Noto Sans

## 📱 Screens

1. **Splash Screen** - App initialization with branding
2. **Login Screen** - Google Sign-In with beautiful gradient background
3. **Home Screen** - Main dashboard with navigation

## 🔧 Configuration

### API Configuration
Update the base URL in `lib/data/network/constants/api_constants.dart`:
```dart
static const String baseUrl = 'YOUR_API_URL';
```

### Firebase Setup (for Google Sign-In)
1. Add `google-services.json` to `android/app/`
2. Add `GoogleService-Info.plist` to `ios/Runner/`

## 🧪 Testing

Run tests:
```bash
flutter test
```

Run with coverage:
```bash
flutter test --coverage
```

## 📝 Code Style

This project follows the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style).

Run formatter:
```bash
flutter format .
```

Run analyzer:
```bash
flutter analyze
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is private and proprietary. All rights reserved.

## 👥 Team

- **Developer**: Phan Duc Anh
- **GitHub**: [@AnhPhan27](https://github.com/AnhPhan27)

## 📞 Support

For support, email: support@vanglai.com

## 🔗 Links

- [Repository](https://github.com/AnhPhan27/vanglai-app.git)
- [Documentation](./PROJECT_STRUCTURE.md)
- [Copilot Instructions](./copilot.md)

---

Made with ❤️ using Flutter
