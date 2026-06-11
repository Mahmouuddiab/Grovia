import 'package:dartz/dartz.dart';
import 'package:grovia/core/error/failure.dart';
import 'package:grovia/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:grovia/features/auth/domain/entity/forgot_password_entity.dart';
import 'package:grovia/features/auth/domain/entity/login_entity.dart';
import 'package:grovia/features/auth/domain/entity/register_entity.dart';
import 'package:grovia/features/auth/domain/entity/user_entity.dart';
import 'package:grovia/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDs remote;
  AuthRepositoryImpl({required this.remote});
  @override
  Future<Either<Failure, UserEntity>> register(RegisterEntity registerEntity)async{
    final user = await remote.register(registerEntity);
    return Right(user);
  }

  @override
  Future<Either<Failure, UserEntity>> login(LoginEntity loginEntity)async{
    final user = await remote.login(loginEntity);
    return Right(user);
  }

  @override
  Future<Either<Failure, void>> forgotPassword(ForgotPasswordEntity forgot)async{
    final dto = await remote.forgotPassword(forgot);
    return Right(dto) ;
  }
}
