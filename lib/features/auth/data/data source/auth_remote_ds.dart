import 'package:grovia/features/auth/data/models/user_model.dart';
import 'package:grovia/features/auth/domain/entity/register_entity.dart';

abstract class AuthRemoteDs {
  Future<UserModel> register(RegisterEntity registerEntity);
}