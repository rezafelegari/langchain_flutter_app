import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'api_endpoints.dart';
import 'network_manager.dart';

class NetworkManagerImpl implements NetworkManager {
  final dio = Dio(BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    headers: {'Authorization': dotenv.env['AuthorizationToken']},
  ));

  @override
  Future<Response> getCall(Uri uri) async {
    final response = await dio.getUri(uri);
    return response;
  }

  @override
  Future<Response> postCall(Uri uri, Object data) async {
    if (data is FormData) {
      dio.options.contentType = 'multipart/form-data';
    } else {
      dio.options.contentType = 'application/json';
    }
    final response = await dio.postUri(uri, data: data);
    return response;
  }
}
