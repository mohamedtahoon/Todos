import 'package:flutter/material.dart';
import 'package:to_do_app/feature/todo/model/todo_response_model.dart';

class TodoDetailsScreen extends StatelessWidget {
  final TodoResponseModel todo;

  TodoDetailsScreen({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('ID: ${todo.id}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('User ID: ${todo.userId}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Completed: ${todo.completed ? 'Yes' : 'No'}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
