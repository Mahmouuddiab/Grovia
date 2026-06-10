import 'package:grovia/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.phone,
    required super.createdAt,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = json['data']['user'];
    final token = json['data']['token'];

    return UserModel(
      id: user['id'],
      username: user['username'],
      email: user['email'],
      phone: user['phone'],
      createdAt: user['created_at'],
      token: token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "phone": phone,
      "created_at": createdAt,
      "token": token,
    };
  }
}