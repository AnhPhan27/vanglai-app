import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vanglai_app/common/theme/app_text_styles.dart';
import 'package:vanglai_app/common/theme/app_colors.dart';
import 'package:vanglai_app/common/utils/validators.dart';
import 'package:vanglai_app/gen/assets.gen.dart';
import 'package:vanglai_app/presentation/widgets/app_image.dart';
import 'package:vanglai_app/presentation/widgets/app_text_field.dart';
import 'dart:ui';
import '../../base/base_state.dart';
import '../../cubits/login/login_cubit.dart';
import '../../cubits/login/login_state.dart';
import '../../../di/service_locator.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/app_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleGoogleSignIn(BuildContext context) {
    context.read<LoginCubit>().signInWithGoogle();
  }

  void _handleEmailLogin(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().loginWithEmail(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  void _handleLoginSuccess(BuildContext context, LoginSuccess state) {
    // Navigate to home based on provider
    context.go(AppRoutes.home);

    // Show welcome message
    final userName = state.supabaseUser.email?.split('@').first ?? 'User';
    showSnackBar('Welcome back, $userName!');
  }

  void _handleLoginError(BuildContext context, LoginError state) {
    // Show error with provider info
    showSnackBar(state.message, isError: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt()),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              _handleLoginSuccess(context, state);
            } else if (state is LoginError) {
              _handleLoginError(context, state);
            }
          },
          builder: (context, state) {
            final isGoogleLoading =
                state is LoginLoading && state.provider == AuthProvider.google;
            final isEmailLoading =
                state is LoginLoading && state.provider == AuthProvider.email;

            return Stack(
              children: [
                // Background Image with Blur
                Positioned.fill(
                  child: Stack(
                    children: [
                      // Blurred background image
                      Positioned.fill(
                        child: Transform.scale(
                          scale: 1.1,
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: 12,
                              sigmaY: 12,
                            ),
                            child: AppImage(
                              imageUrl: Assets.images.imgBackground.path,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      // Gradient overlay
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(16, 185, 129, 0.6),
                                Colors.transparent,
                                Color.fromRGBO(244, 140, 37, 0.6),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Dark overlay
                      Positioned.fill(
                        child: Container(color: AppColors.black40),
                      ),
                    ],
                  ),
                ),
                // Content
                SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Join the community.',
                                  style: AppTextStyles.titleLarge.copyWith(
                                    color: Colors.white,
                                    height: 1.2,
                                    shadows: const [
                                      Shadow(
                                        color: AppColors.black30,
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Find your court.',
                                  style: AppTextStyles.titleLarge.copyWith(
                                    color: AppColors.white90,
                                    height: 1.2,
                                    shadows: const [
                                      Shadow(
                                        color: AppColors.black30,
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Play today.',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFf48c25),
                                    height: 1.2,
                                    shadows: [
                                      Shadow(
                                        color: AppColors.black26,
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Bottom Section with Login Options
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Email Input
                              AppTextField(
                                controller: _emailController,
                                labelText: 'Email',
                                prefixIcon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                validator: Validators.validateEmail,
                              ),
                              const SizedBox(height: 16),
                              // Password Input
                              AppTextField(
                                controller: _passwordController,
                                labelText: 'Password',
                                prefixIcon: Icons.lock_outline,
                                obscureText: true,
                                validator: Validators.validatePassword,
                              ),
                              const SizedBox(height: 24),
                              // Login Button
                              AppButton(
                                text: 'Sign In',
                                onPressed: () => _handleEmailLogin(context),
                                type: AppButtonType.primary,
                                isLoading: isEmailLoading,
                                isFullWidth: true,
                              ),
                              const SizedBox(height: 16),
                              // Divider
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: AppColors.white30,
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      'OR',
                                      style: TextStyle(
                                        color: AppColors.white50,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors.white30,
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Google Sign In Button
                              AppButton(
                                text: 'Continue with Google',
                                onPressed: () => _handleGoogleSignIn(context),
                                type: AppButtonType.google,
                                isLoading: isGoogleLoading,
                                isFullWidth: true,
                              ),
                              const SizedBox(height: 24),
                              // Terms and Privacy
                              Text.rich(
                                TextSpan(
                                  text: 'By continuing, you agree to our ',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: AppColors.white50,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Terms',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.white30,
                                      ),
                                    ),
                                    const TextSpan(text: ' and '),
                                    const TextSpan(
                                      text: 'Privacy',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.white30,
                                      ),
                                    ),
                                    const TextSpan(text: '.'),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
