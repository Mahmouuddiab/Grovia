import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, {this.statusCode});

  @override
  String toString() => message;
}


///  NETWORK EXCEPTIONS
class NetworkException extends AppException {
  NetworkException(super.message, {super.statusCode});
}

class TimeoutException extends AppException {
  TimeoutException(super.message);
}

class BadRequestException extends AppException {
  BadRequestException(super.message, {super.statusCode});
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message, {super.statusCode});
}

class ForbiddenException extends AppException {
  ForbiddenException(super.message, {super.statusCode});
}

class NotFoundException extends AppException {
  NotFoundException(super.message, {super.statusCode});
}

class ServerException extends AppException {
  ServerException(super.message, {super.statusCode});
}

class UnknownException extends AppException {
  UnknownException(super.message);
}


// EXCEPTION HANDLER

class ExceptionHandler {
  static AppException handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return TimeoutException("Request timeout");

        case DioExceptionType.connectionError:
          return NetworkException("No internet connection");

        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final message = _extractMessage(error.response?.data);

          switch (statusCode) {
            case 400:
              return BadRequestException(message, statusCode: 400);
            case 401:
              return UnauthorizedException(message, statusCode: 401);
            case 403:
              return ForbiddenException(message, statusCode: 403);
            case 404:
              return NotFoundException(message, statusCode: 404);
            case 500:
            default:
              return ServerException(message, statusCode: statusCode);
          }

        case DioExceptionType.cancel:
          return NetworkException("Request cancelled");

        default:
          return UnknownException("Unexpected error occurred");
      }
    }

    return UnknownException(error.toString());
  }

  static String _extractMessage(dynamic data) {
    try {
      if (data is Map<String, dynamic>) {
        return data['message'] ?? 'Something went wrong';
      }
      return data.toString();
    } catch (_) {
      return 'Unknown error';
    }
  }
}