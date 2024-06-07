import 'package:dio/dio.dart';
import 'package:langchain_flutter_app/repository/langchain_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langchain_flutter_app/states/states.dart';

class UpsertCubit extends Cubit<UpsertState> {
  final LangChainRepository _langChainRepository;

  UpsertCubit(this._langChainRepository) : super(UpsertInitial());

  void upsertDocument(FormData formData) async {
    try {
      emit(UpsertLoading());
      Response<dynamic> response =
          await _langChainRepository.upsertDocument(formData);
      emit(UpsertLoaded(response.data['numAdded'].toString()));
    } catch (e) {
      emit(UpsertError(e.toString()));
    }
  }
}
