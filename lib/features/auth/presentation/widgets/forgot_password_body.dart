import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grovia/core/router/app_routes.dart';
import 'package:grovia/core/validator/app_validator.dart';
import 'package:grovia/features/auth/domain/entity/forgot_password_entity.dart';
import 'package:grovia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:grovia/features/auth/presentation/cubit/auth_state.dart';
import 'package:grovia/features/auth/presentation/widgets/auth_text_field.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    final input = _identifierController.text.trim();
    final isEmail = input.contains('@');

    context.read<AuthCubit>().forgotPassword(
      ForgotPasswordEntity(isEmail ? input : '', !isEmail ? input : ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Reset request sent successfully'),
                backgroundColor: theme.colorScheme.primary,
              ),
            );
            // Navigator.pop(context);
          }

          if (state is ForgotPasswordErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ForgotPasswordLoadingState;

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
                        const SizedBox(height: 80),

                        Icon(
                          Icons.lock_reset,
                          size: 80,
                          color: theme.colorScheme.primary,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          "Forgot Password?",
                          style: theme.textTheme.headlineMedium,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Enter your email or phone number to reset your password",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium,
                        ),

                        const SizedBox(height: 60),

                        AuthTextField(
                          controller: _identifierController,
                          label: 'Email or Phone Number',
                          icon: Icons.person_outline,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field cannot be empty';
                            }

                            final trimmedInput = value.trim();

                            // Contextually validate using your core validation helpers
                            if (trimmedInput.contains('@')) {
                              return AppValidator.validateEmail(trimmedInput);
                            } else {
                              return AppValidator.validatePhone(trimmedInput);
                            }
                          },
                        ),

                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _submit,
                            child: isLoading
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  )
                                : const Text('Send Reset Link'),
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextButton(
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, AppRoutes.login);
                          },
                          child: const Text('Back to Login'),
                        ),
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
}
