import 'package:dartz/dartz.dart';
import 'package:grovia/core/error/failure.dart';
import 'package:grovia/features/auth/domain/entity/login_entity.dart';
import 'package:grovia/features/auth/domain/entity/user_entity.dart';
import 'package:grovia/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);
  Future<Either<Failure, UserEntity>> call(LoginEntity loginEntity) {
    return repository.login(loginEntity);
  }
}
