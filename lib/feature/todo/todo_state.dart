part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodosInitial extends TodoState {}

class TodosLoading extends TodoState {}

class TodosLoaded extends TodoState {
  final List<TodoResponseModel> todos;
  final bool hasMore;
  final String filter;

  TodosLoaded({required this.todos, this.hasMore = true, this.filter = 'All'});
}

class TodosError extends TodoState {
  final String message;

  TodosError({required this.message});
}
