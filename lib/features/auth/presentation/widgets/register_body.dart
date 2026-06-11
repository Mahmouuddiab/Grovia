import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grovia/core/router/app_routes.dart';
import 'package:grovia/core/validator/app_validator.dart';
import 'package:grovia/features/auth/domain/entity/register_entity.dart';
import 'package:grovia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:grovia/features/auth/presentation/cubit/auth_state.dart';
import 'package:grovia/features/auth/presentation/widgets/auth_text_field.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    for (var controller in [
      _usernameController,
      _emailController,
      _phoneController,
      _passwordController,
      _confirmPasswordController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    await context.read<AuthCubit>().register(
      RegisterEntity(
        email: _emailController.text.trim(),
        username: _usernameController.text.trim(),
        phone: _phoneController.text.trim(),
        password: _passwordController.text.trim(),
        passwordConfirmation: _confirmPasswordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // Automatically uses AppTheme scaffoldBackgroundColor (light/dark)
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Account created successfully'),
                backgroundColor: theme.colorScheme.onPrimary,
              ),
            );
          }
          if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: theme.colorScheme.error, // Derived from theme
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is RegisterLoadingState;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),

                        // App Logo Section
                        Image.asset(
                          "assets/images/logo.png",
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 24),

                        Text(
                          "Create Account",
                          style: theme
                              .textTheme
                              .headlineMedium, // Clean global typography
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Fill in your details to get started",
                          style: theme
                              .textTheme
                              .bodyMedium, // Dynamic grey/slate from theme
                        ),
                        const SizedBox(height: 40),

                        // Input Fields Inherit Theme Automatically
                        _buildFieldSection(),

                        const SizedBox(height: 32),

                        // Main Action Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _register,
                            // Extra styling removed! Handled directly by elevatedButtonTheme
                            child: isLoading
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: theme
                                          .colorScheme
                                          .onPrimary, // Dynamic loader indicator
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Sign Up'),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Footer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: theme.textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.login,
                                );
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: theme
                                      .colorScheme
                                      .primary, // Adapts to Light/Dark color shifts
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFieldSection() {
    return Column(
      children: [
        AuthTextField(
          controller: _usernameController,
          label: 'Username',
          icon: Icons.person_outline,
          validator: (_) =>
              AppValidator.validateUsername(_usernameController.text),
        ),
        const SizedBox(height: 18),
        AuthTextField(
          controller: _emailController,
          label: 'Email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (_) => AppValidator.validateEmail(_emailController.text),
        ),
        const SizedBox(height: 18),
        AuthTextField(
          controller: _phoneController,
          label: 'Phone',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (_) => AppValidator.validatePhone(_phoneController.text),
        ),
        const SizedBox(height: 18),
        AuthTextField(
          controller: _passwordController,
          label: 'Password',
          icon: Icons.lock_outline,
          isPassword: true,
          validator: (_) =>
              AppValidator.validatePassword(_passwordController.text),
        ),
        const SizedBox(height: 18),
        AuthTextField(
          controller: _confirmPasswordController,
          label: 'Confirm Password',
          icon: Icons.lock_reset_outlined,
          isPassword: true,
          validator: (_) => AppValidator.validateConfirmPassword(
            _confirmPasswordController.text,
            _passwordController.text,
          ),
        ),
      ],
    );
  }
}
