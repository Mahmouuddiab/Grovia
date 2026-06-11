import 'package:grovia/features/auth/data/models/user_model.dart';
import 'package:grovia/features/auth/domain/entity/forgot_password_entity.dart';
import 'package:grovia/features/auth/domain/entity/login_entity.dart';
import 'package:grovia/features/auth/domain/entity/register_entity.dart';

abstract class AuthRemoteDs {
  Future<UserModel> register(RegisterEntity registerEntity);
  Future<UserModel> login(LoginEntity loginEntity);
  Future<void> forgotPassword(ForgotPasswordEntity forgot);
}