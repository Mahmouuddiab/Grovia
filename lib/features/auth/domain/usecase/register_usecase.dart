import 'package:dartz/dartz.dart';
import 'package:grovia/core/error/failure.dart';
import 'package:grovia/features/auth/domain/entity/register_entity.dart';
import 'package:grovia/features/auth/domain/entity/user_entity.dart';
import 'package:grovia/features/auth/domain/repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);
  Future<Either<Failure, UserEntity>> call(RegisterEntity registerEntity) {
    return repository.register(registerEntity);
  }
}
