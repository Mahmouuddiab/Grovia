import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grovia/core/constants/api_constant.dart';
import 'package:grovia/core/constants/bloc_observer.dart';
import 'package:grovia/core/constants/dio_helper.dart';
import 'package:grovia/core/di/get_it.dart';
import 'package:grovia/core/theme/app_theme.dart';
import 'package:grovia/features/auth/presentation/screens/register_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  Bloc.observer = AppBlocObserver();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grovia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: RegisterScreen(),
    );
  }
}

