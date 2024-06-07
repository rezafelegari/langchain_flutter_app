import 'package:dio/dio.dart';

abstract class LangChainRepository {
  /// Upsert document to the flowise system.
  Future<Response<dynamic>> upsertDocument(FormData formData);

  /// Ask question and get response.
  Future<Response<dynamic>> query(String question);
}
