import 'package:storage/app/core/adapters/http_client/http_response.dart';

abstract class AppHttpClient {
  const AppHttpClient();

  Future<HttpResponse> get<T>(String path, {dynamic queryParameters});
  Future<HttpResponse> post(String path, {required dynamic data});
}
