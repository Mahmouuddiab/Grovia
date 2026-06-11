import 'package:grovia/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.phone,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final user = data['user'] ?? {};

    return UserModel(
      id: user['id'] ?? 0,
      username: user['username'] ?? '',
      email: user['email'] ?? '',
      phone: user['phone'] ?? '',
      token: data['token'] ?? '',
    );
  }
}
