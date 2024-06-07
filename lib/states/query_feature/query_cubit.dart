import 'package:dio/dio.dart';
import 'package:langchain_flutter_app/repository/langchain_repository.dart';
import 'package:langchain_flutter_app/states/query_feature/query_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QueryCubit extends Cubit<QueryState> {
  final LangChainRepository _langChainRepository;

  QueryCubit(this._langChainRepository) : super(QueryInitial());

  void askQuestion(String question) async {
    try {
      emit(QueryLoading());
      Response<dynamic> response = await _langChainRepository.query(question);
      emit(QueryLoaded(removeExtraLines(response.data['text'])));
    } catch (e) {
      emit(QueryError(e.toString()));
    }
  }

  String removeExtraLines(String text) {
    return text.trim().replaceAll(RegExp(r'\n\s*\n'), '\n');
  }
}
