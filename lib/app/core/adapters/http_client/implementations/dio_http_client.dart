import 'package:dio/dio.dart';
import 'package:storage/app/core/adapters/http_client/http_client.dart';
import 'package:storage/app/core/adapters/http_client/http_exception.dart';
import 'package:storage/app/core/adapters/http_client/http_response.dart';

class DioHttpClient implements AppHttpClient {
  final Dio _dio;

  const DioHttpClient({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<HttpResponse> get<T>(String path, {queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);

      return HttpResponse(data: response.data);
    } on DioException catch (error) {
      throw AppHttpException(
        message: error.message ?? '',
        stackTrace: error.stackTrace,
      );
    }
  }

  @override
  Future<HttpResponse> post(String path, {required data}) async {
    try {
      final response = await _dio.post(path, data: data);

      return HttpResponse(data: response.data);
    } on DioException catch (error) {
      throw AppHttpException(
        message: error.message ?? '',
        stackTrace: error.stackTrace,
      );
    }
  }
}
