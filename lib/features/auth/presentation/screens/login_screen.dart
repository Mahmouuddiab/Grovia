import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grovia/core/di/get_it.dart';
import 'package:grovia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:grovia/features/auth/presentation/widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: const LoginBody(),
    );
  }
}
