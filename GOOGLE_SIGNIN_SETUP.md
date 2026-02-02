# Hướng dẫn tích hợp Google Sign In với Supabase

## 1. Cấu hình Supabase

### Bước 1: Tạo project trên Supabase
1. Truy cập [Supabase](https://supabase.com)
2. Tạo project mới hoặc sử dụng project có sẵn

### Bước 2: Lấy thông tin API
1. Vào **Settings** > **API**
2. Copy **Project URL** và **anon public key**
3. Cập nhật vào file `lib/data/network/constants/supabase_constants.dart`

### Bước 3: Cấu hình Google OAuth Provider
1. Vào **Authentication** > **Providers** trong Supabase Dashboard
2. Tìm **Google** và enable
3. Cần có **Client ID** và **Client Secret** từ Google Cloud Console

## 2. Cấu hình Google Cloud Console

### Bước 1: Tạo OAuth 2.0 Client
1. Truy cập [Google Cloud Console](https://console.cloud.google.com)
2. Tạo project mới hoặc chọn project có sẵn
3. Vào **APIs & Services** > **Credentials**
4. Click **Create Credentials** > **OAuth client ID**

### Bước 2: Cấu hình cho iOS
1. Chọn **iOS** application type
2. Nhập Bundle ID của app (lấy từ `ios/Runner.xcodeproj/project.pbxproj`)
3. Download file `GoogleService-Info.plist`
4. Copy **iOS URL scheme** (format: `com.googleusercontent.apps.REVERSED_CLIENT_ID`)

### Bước 3: Cấu hình cho Android
1. Chọn **Android** application type
2. Nhập package name (lấy từ `android/app/build.gradle.kts`)
3. Nhập SHA-1 certificate fingerprint:
   ```bash
   # Debug keystore
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```

### Bước 4: Cấu hình Web Client (quan trọng cho Supabase)
1. Tạo thêm một **Web application** OAuth client
2. Copy **Client ID** và **Client Secret**
3. Thêm vào Supabase: **Authentication** > **Providers** > **Google**

## 3. Cấu hình iOS

### Bước 1: Cập nhật Info.plist
Thêm vào `ios/Runner/Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <!-- Replace with your REVERSED_CLIENT_ID -->
      <string>com.googleusercontent.apps.YOUR_REVERSED_CLIENT_ID</string>
    </array>
  </dict>
</array>
<key>GIDClientID</key>
<string>YOUR_IOS_CLIENT_ID</string>
```

### Bước 2: Thêm GoogleService-Info.plist (nếu cần)
1. Copy file `GoogleService-Info.plist` vào thư mục `ios/Runner/`
2. Mở Xcode và add file này vào project

## 4. Cấu hình Android

### Bước 1: Cập nhật AndroidManifest.xml
File `android/app/src/main/AndroidManifest.xml` đã được cấu hình sẵn bởi plugin `google_sign_in`.

### Bước 2: Tạo google-services.json (nếu dùng Firebase)
1. Download từ Firebase Console
2. Copy vào `android/app/`

## 5. Khởi tạo trong main.dart

Cập nhật file `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:vanglai_app/data/network/constants/supabase_constants.dart';
import 'package:vanglai_app/data/network/services/supabase_service.dart';
import 'package:vanglai_app/data/network/services/google_sign_in_service.dart';
import 'di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Khởi tạo Supabase
  await SupabaseService.initialize(
    url: SupabaseConstants.projectUrl,
    anonKey: SupabaseConstants.anonKey,
  );
  
  // Setup dependency injection
  await setupServiceLocator();
  
  // Khởi tạo Google Sign In
  await getIt<GoogleSignInService>().initialize();
  
  runApp(const MyApp());
}
```

## 6. Sử dụng trong code

### Trong LoginPage hoặc LoginCubit:

```dart
// Lấy AuthRepository từ GetIt
final authRepo = getIt<AuthRepository>();

try {
  // Đăng nhập với Google
  final user = await authRepo.signInWithGoogle();
  print('Logged in: ${user.email}');
  
  // Hoặc đăng nhập với email/password
  final user2 = await authRepo.signInWithEmailPassword(
    email: 'user@example.com',
    password: 'password123',
  );
  
} on AppException catch (e) {
  print('Error: ${e.message}');
}

// Đăng xuất
await authRepo.signOut();

// Kiểm tra trạng thái đăng nhập
if (authRepo.isSignedIn) {
  print('User is signed in');
}
```

## 7. Test

### Test trên iOS Simulator:
```bash
flutter run -d "iPhone 15 Pro"
```

### Test trên Android Emulator:
```bash
flutter run -d emulator-5554
```

### Test trên device thật:
```bash
flutter run -d <device-id>
```

## 8. Troubleshooting

### Lỗi "API not enabled"
- Enable Google+ API trong Google Cloud Console
- Enable Identity Toolkit API

### Lỗi "Invalid client ID"
- Kiểm tra Client ID trong iOS Info.plist
- Đảm bảo Bundle ID khớp với Google Console

### Lỗi "12501: SIGN_IN_CANCELLED" trên Android
- Kiểm tra SHA-1 certificate fingerprint
- Đảm bảo package name khớp

### Lỗi Supabase "Invalid credentials"
- Kiểm tra Web Client ID và Secret trong Supabase
- Đảm bảo Google Provider đã được enable

## 9. Bảo mật

### Không commit sensitive data:
1. Tạo file `.env` hoặc `lib/config/env.dart` (thêm vào .gitignore)
2. Lưu Supabase URL và keys trong đó
3. Sử dụng `flutter_dotenv` hoặc custom config loader

### Ví dụ với environment variables:
```dart
// pubspec.yaml
dependencies:
  flutter_dotenv: ^5.1.0

// .env (thêm vào .gitignore)
SUPABASE_URL=your_url
SUPABASE_ANON_KEY=your_key

// lib/main.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  
  await SupabaseService.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  
  runApp(const MyApp());
}
```

## 10. Deep Linking (Optional)

Nếu cần xử lý email verification hoặc password reset links:

### iOS (ios/Runner/Info.plist):
```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>your-app-scheme</string>
    </array>
  </dict>
</array>
```

### Android (android/app/src/main/AndroidManifest.xml):
```xml
<intent-filter android:autoVerify="true">
  <action android:name="android.intent.action.VIEW" />
  <category android:name="android.intent.category.DEFAULT" />
  <category android:name="android.intent.category.BROWSABLE" />
  <data android:scheme="your-app-scheme" android:host="login-callback" />
</intent-filter>
```

---

**Lưu ý:** Đảm bảo thay thế tất cả các placeholder (YOUR_*, your-*) bằng giá trị thực tế từ project của bạn.
