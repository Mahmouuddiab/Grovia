import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grovia/features/auth/domain/entity/forgot_password_entity.dart';
import 'package:grovia/features/auth/domain/entity/login_entity.dart';
import 'package:grovia/features/auth/domain/entity/register_entity.dart';
import 'package:grovia/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:grovia/features/auth/domain/usecase/login_usecase.dart';
import 'package:grovia/features/auth/domain/usecase/register_usecase.dart';
import 'package:grovia/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState>{
  RegisterUseCase registerUseCase;
  LoginUseCase loginUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  AuthCubit(this.registerUseCase,this.loginUseCase,this.forgotPasswordUseCase):super(AuthInitialState());

  Future<void> register(RegisterEntity registerEntity)async{
    emit(RegisterLoadingState());
    final response = await registerUseCase.call(registerEntity);
    return response.fold(
          (l) {
        emit(RegisterErrorState(error: "can't register ${l.message}"));
      },
          (r) {
        emit(RegisterSuccessState());
      },
    ) ;
  }
  Future<void> login(LoginEntity loginEntity)async{
    emit(LoginLoadingState());
    final response = await loginUseCase.call(loginEntity);
    return response.fold(
          (l) {
        emit(LoginErrorState(error: "can't login ${l.message}"));
      },
          (r) {
        emit(LoginSuccessState());
      },
    ) ;
  }

  Future<void> forgotPassword(ForgotPasswordEntity forgot) async {
    emit(ForgotPasswordLoadingState());
    final response = await forgotPasswordUseCase.call(forgot);
    response.fold(
          (l) => emit(ForgotPasswordErrorState(error: "Can't send reset: ${l.message}")),
          (r) => emit(ForgotPasswordSuccessState()),
    );
  }

}