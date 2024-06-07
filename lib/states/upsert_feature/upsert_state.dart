abstract class UpsertState {}

class UpsertInitial extends UpsertState {}

class UpsertLoading extends UpsertState {}

class UpsertLoaded extends UpsertState {
  final String data;

  UpsertLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class UpsertError extends UpsertState {
  final String error;

  UpsertError(this.error);

  @override
  List<Object> get props => [error];
}
