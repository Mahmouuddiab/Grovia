import 'package:dartz/dartz.dart';
import 'package:grovia/core/error/failure.dart';
import 'package:grovia/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:grovia/features/auth/domain/entity/register_entity.dart';
import 'package:grovia/features/auth/domain/entity/user_entity.dart';
import 'package:grovia/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDs remote;
  AuthRepositoryImpl({required this.remote});
  @override
  Future<Either<Failure, UserEntity>> register(
    RegisterEntity registerEntity,
  ) async {
    final user = await remote.register(registerEntity);
    return Right(user);
  }
}
