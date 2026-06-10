import 'package:dio/dio.dart';
import 'package:grovia/core/constants/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final AuthStorage _authStorage = AuthStorage();

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final String? token = await _authStorage.token;

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    if (err.response?.statusCode == 401) {
      await _authStorage.clear();
    }

    handler.next(err);
  }
}