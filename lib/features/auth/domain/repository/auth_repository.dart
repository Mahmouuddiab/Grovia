import 'package:dartz/dartz.dart';
import 'package:grovia/core/error/failure.dart';
import 'package:grovia/features/auth/domain/entity/forgot_password_entity.dart';
import 'package:grovia/features/auth/domain/entity/login_entity.dart';
import 'package:grovia/features/auth/domain/entity/register_entity.dart';
import 'package:grovia/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure,UserEntity>> register(RegisterEntity registerEntity);
  Future<Either<Failure,UserEntity>> login(LoginEntity loginEntity);
  Future<Either<Failure,void>> forgotPassword(ForgotPasswordEntity forgot);
}