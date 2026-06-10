import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureKeys {
  static const String token = 'token';
  static const String userId = 'user_id';
}


class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  factory SecureStorage() => _instance;
  SecureStorage._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  /// WRITE
  Future<void> write(String key, Object value) async {
    try {
      await _storage.write(
        key: key,
        value: jsonEncode(value),
      );
    } catch (_) {}
  }

  /// READ
  Future<T?> read<T>(String key) async {
    try {
      final value = await _storage.read(key: key);
      if (value == null) return null;
      return jsonDecode(value) as T;
    } catch (_) {
      return null;
    }
  }

  /// DELETE
  Future<void> remove(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (_) {}
  }

  /// CLEAR ALL
  Future<void> clear() async {
    try {
      await _storage.deleteAll();
    } catch (_) {}
  }
}


class AuthStorage {
  static final AuthStorage _instance = AuthStorage._internal();
  factory AuthStorage() => _instance;
  AuthStorage._internal();

  final SecureStorage _storage = SecureStorage();

  /// TOKEN
  Future<String?> get token async =>
      await _storage.read<String>(SecureKeys.token);

  Future<void> setToken(String value) async {
    await _storage.write(SecureKeys.token, value);
  }

  /// USER ID
  Future<String?> get userId async =>
      await _storage.read<String>(SecureKeys.userId);

  Future<void> setUserId(String value) async {
    await _storage.write(SecureKeys.userId, value);
  }

  /// CLEAR AUTH DATA
  Future<void> clear() async {
    await _storage.remove(SecureKeys.token);
    await _storage.remove(SecureKeys.userId);
  }
}