abstract class AuthState {}

class AuthInitialState extends AuthState {}

class RegisterLoadingState extends AuthState {}
class RegisterSuccessState extends AuthState {}
class RegisterErrorState extends AuthState {
  final String error;
  RegisterErrorState({required this.error});
}

class LoginLoadingState extends AuthState{}
class LoginSuccessState extends AuthState {}
class LoginErrorState extends AuthState {
  final String error;
  LoginErrorState({required this.error});
}

class ForgotPasswordLoadingState extends AuthState {}
class ForgotPasswordSuccessState extends AuthState {}
class ForgotPasswordErrorState extends AuthState {
  final String error;
  ForgotPasswordErrorState({required this.error});
}