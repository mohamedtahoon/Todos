import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/core/api/api_service.dart';
import 'package:to_do_app/feature/todo/model/todo_response_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ApiService apiService;
  List<TodoResponseModel> _allTodos = [];
  int _nextIndex = 0;
  final int _pageSize = 20;

  TodoBloc({required this.apiService}) : super(TodosInitial()) {
    on<FetchTodos>((event, emit) async {
      emit(TodosLoading());
      try {
        _allTodos = await apiService.fetchTodos();
        emit(TodosLoaded(todos: _allTodos.sublist(0, _pageSize)));
      } catch (e) {
        emit(TodosError(message: e.toString()));
      }
    });

    on<AddMoreTodos>((event, emit) async {
      if (state is TodosLoaded) {
        final currentState = state as TodosLoaded;
        if (currentState.hasMore) {
          _nextIndex += _pageSize;
          final endIndex = _nextIndex + _pageSize;
          final partOfTodos = _allTodos.sublist(_nextIndex,
              endIndex > _allTodos.length ? _allTodos.length : endIndex);
          emit(TodosLoaded(
              todos: currentState.todos + partOfTodos,
              hasMore: endIndex < _allTodos.length));
        }
      }
    });
    on<SetFilter>((event, emit) {
      if (state is TodosLoaded) {
        final currentState = state as TodosLoaded;
        List<TodoResponseModel> filteredTodos;
        if (event.filter == 'All') {
          filteredTodos = _allTodos;
        } else {
          bool isCompleted = event.filter == 'Completed';
          filteredTodos =
              _allTodos.where((todo) => todo.completed == isCompleted).toList();
        }
        emit(TodosLoaded(
            todos: filteredTodos,
            hasMore: currentState.hasMore,
            filter: event.filter));
      }
    });
  }
}
