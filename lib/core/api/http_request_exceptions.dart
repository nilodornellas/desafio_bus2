import 'package:dio/dio.dart';

class HttpRequestException implements Exception {
  final String message;
  final int? statusCode;

  HttpRequestException(this.message, {this.statusCode});

  factory HttpRequestException.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return HttpRequestException('Tempo de conexão excedido');
      case DioExceptionType.receiveTimeout:
        return HttpRequestException('Tempo de resposta excedido');
      case DioExceptionType.badResponse:
        return HttpRequestException(
          'Erro do servidor: ${e.response?.statusCode}',
          statusCode: e.response?.statusCode,
        );
      default:
        return HttpRequestException('Erro inesperado: ${e.message}');
    }
  }

  @override
  String toString() => 'HttpRequestException($statusCode): $message';
}
