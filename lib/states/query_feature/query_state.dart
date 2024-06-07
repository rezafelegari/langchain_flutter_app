abstract class QueryState {}

class QueryInitial extends QueryState {}

class QueryLoading extends QueryState {}

class QueryLoaded extends QueryState {
  final String data;

  QueryLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class QueryError extends QueryState {
  final String error;

  QueryError(this.error);

  @override
  List<Object> get props => [error];
}
