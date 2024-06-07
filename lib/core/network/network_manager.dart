import 'package:dio/dio.dart';

abstract class NetworkManager {
  /// Call post http request.
  Future<Response> postCall(Uri uri, Object data);

  /// Call get http request.
  Future<Response> getCall(Uri uri);
}
