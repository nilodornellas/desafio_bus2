import 'package:dio/dio.dart';

class HttpRequestException implements Exception {
  final String message;
  final int? statusCode;

  HttpRequestException(this.message, {this.statusCode});

  factory HttpRequestException.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return HttpRequestException('Connection timeout');
      case DioExceptionType.receiveTimeout:
        return HttpRequestException('Response time exceeded');
      case DioExceptionType.badResponse:
        return HttpRequestException(
          'Server error: ${e.response?.statusCode}',
          statusCode: e.response?.statusCode,
        );
      default:
        return HttpRequestException('Unexpected error: ${e.message}');
    }
  }

  @override
  String toString() => 'HttpRequestException($statusCode): $message';
}
