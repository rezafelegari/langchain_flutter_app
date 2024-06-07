import 'package:langchain_flutter_app/core/core.dart';
import 'package:dio/dio.dart';

import 'langchain_repository.dart';

class LangChainRepositoryImpl implements LangChainRepository {
  final NetworkManager _networkManager;

  LangChainRepositoryImpl(this._networkManager);

  @override
  Future<Response<dynamic>> query(String question) {
    return _networkManager
        .postCall(Uri(path: ApiEndpoints.prediction), {'question': question});
  }

  @override
  Future<Response<dynamic>> upsertDocument(FormData formData) {
    return _networkManager.postCall(
      Uri(path: ApiEndpoints.upsert),
      formData,
    );
  }
}
