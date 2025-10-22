import 'package:desafio_bus2/core/api/http_client.dart';
import 'package:desafio_bus2/core/api/http_request_exceptions.dart';
import 'package:dio/dio.dart';

class DioHttpClient implements HttpClient {
  final Dio _dio;

  DioHttpClient({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://randomuser.me/api/',
              contentType: 'application/json',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw HttpRequestException.fromDioError(e);
    }
  }

  @override
  Future<dynamic> post(String path, {data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw HttpRequestException.fromDioError(e);
    }
  }

  @override
  Future<dynamic> put(String path, {data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw HttpRequestException.fromDioError(e);
    }
  }

  @override
  Future<dynamic> patch(String path, {data}) async {
    try {
      final response = await _dio.patch(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw HttpRequestException.fromDioError(e);
    }
  }

  @override
  Future<dynamic> delete(String path) async {
    try {
      final response = await _dio.patch(path);
      return response.data;
    } on DioException catch (e) {
      throw HttpRequestException.fromDioError(e);
    }
  }
}
