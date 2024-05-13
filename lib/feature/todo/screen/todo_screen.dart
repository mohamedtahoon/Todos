import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/api/api_service.dart';
import 'package:to_do_app/feature/todo/screen/todo_details_screen.dart';
import 'package:to_do_app/feature/todo/todo_bloc.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TodoBloc(apiService: ApiService())..add(FetchTodos()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo Titles'),
          actions: [
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                return DropdownButton<String>(
                  value: (state is TodosLoaded) ? state.filter : 'All',
                  icon: const Icon(Icons.filter_list),
                  onChanged: (String? newValue) {
                    context.read<TodoBloc>().add(SetFilter(filter: newValue!));
                  },
                  items: <String>['All', 'Completed', 'Not Completed']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodosLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TodosError) {
              return Center(child: Text(state.message));
            } else if (state is TodosLoaded) {
              return _buildTodosListView(state);
            } else {
              return const Center(child: Text('No Data Found'));
            }
          },
        ),
      ),
    );
  }

  _buildTodosListView(TodosLoaded state) {
    return ListView.builder(
      itemCount: state.todos.length,
      itemBuilder: (context, index) {
        final todo = state.todos[index];
        return ListTile(
          title: Text(todo.title),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TodoDetailsScreen(todo: todo),
            ));
          },
        );
      },
    );
  }
}
