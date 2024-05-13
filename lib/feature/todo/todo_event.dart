part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class FetchTodos extends TodoEvent {}

class AddMoreTodos extends TodoEvent {}

class SetFilter extends TodoEvent {
  final String filter;

  SetFilter({required this.filter});
}

