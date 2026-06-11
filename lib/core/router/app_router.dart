import 'package:flutter/material.dart';
import 'package:grovia/core/router/app_routes.dart';
import 'package:grovia/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:grovia/features/auth/presentation/screens/login_screen.dart';
import 'package:grovia/features/auth/presentation/screens/register_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case AppRoutes.forgot:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(body: Center(child: Text("Not Found"))),
        );
    }
  }
}