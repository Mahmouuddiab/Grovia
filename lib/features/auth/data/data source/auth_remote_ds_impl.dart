import 'package:grovia/core/constants/api_constant.dart';
import 'package:grovia/core/constants/dio_helper.dart';
import 'package:grovia/core/constants/secure_storage.dart';
import 'package:grovia/core/error/app_exceptions.dart';
import 'package:grovia/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:grovia/features/auth/data/models/user_model.dart';
import 'package:grovia/features/auth/domain/entity/forgot_password_entity.dart';
import 'package:grovia/features/auth/domain/entity/login_entity.dart';
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

  @override
  Future<UserModel> login(LoginEntity loginEntity) async {
    try {
      final response = await DioHelper.post(
        path: ApiConstant.loginEndpoint,
        data: {
          "login": loginEntity.email,
          "password": loginEntity.password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = UserModel.fromJson(response.data);

        if (user.token.isNotEmpty) {
          await AuthStorage().setToken(user.token);
        }

        return user;
      }

      throw ServerException(
        "Login failed with status: ${response.statusCode}",
      );
    } catch (e) {
      throw ServerException("Login error: $e");
    }
  }

  @override
  Future<void> forgotPassword(ForgotPasswordEntity forgot) async {
    try {
      // Determine which value to send as the backend's required 'identifier'
      final String identifier = forgot.email.isNotEmpty ? forgot.email : forgot.phone;

      final response = await DioHelper.post(
        path: ApiConstant.forgotPasswordEndpoint,
        data: {
          "identifier": identifier, // Changed from passing 'email' and 'phone' keys
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      }

      throw ServerException(
        "Forgot password failed with status: ${response.statusCode}",
      );
    } catch (e) {
      throw ServerException("Forgot password error: $e");
    }
  }

}
