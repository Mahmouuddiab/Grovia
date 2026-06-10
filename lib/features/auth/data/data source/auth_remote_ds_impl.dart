import 'package:grovia/core/constants/api_constant.dart';
import 'package:grovia/core/constants/dio_helper.dart';
import 'package:grovia/core/constants/secure_storage.dart';
import 'package:grovia/core/error/app_exceptions.dart';
import 'package:grovia/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:grovia/features/auth/data/models/user_model.dart';
import 'package:grovia/features/auth/domain/entity/register_entity.dart';

class AuthRemoteDsImpl implements AuthRemoteDs {
  @override
  Future<UserModel> register(RegisterEntity registerEntity) async {
    try {
      final response = await DioHelper.post(
        path: ApiConstant.registerEndpoint,
        data: {
          "email": registerEntity.email,
          "username": registerEntity.username,
          "phone": registerEntity.phone,
          "password": registerEntity.password,
          "password_confirmation": registerEntity.passwordConfirmation,
          "agree_terms": 1,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = UserModel.fromJson(response.data);

        final token = user.token;
        if (token.isNotEmpty) {
          await AuthStorage().setToken(token);
        }

        return user;
      } else {
        throw ServerException(
          "Registration failed with status: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw ServerException("Register error: $e");
    }
  }
}