import 'package:dio/dio.dart';
import 'package:to_do_app/core/api/api_keys.dart';
import 'package:to_do_app/feature/todo/model/todo_response_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<TodoResponseModel>> fetchTodos({int page = 1}) async {
    try {
      final response = await _dio.get(
        ApiKeys.toDo,
      );
      if (response.statusCode == 200) {
        List<dynamic> todosJson = response.data;
        List<TodoResponseModel> todos =
            todosJson.map((json) => TodoResponseModel.fromJson(json)).toList();
        return todos;
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      print(e);
      throw Exception('Error occurred while fetching Todos data');
    }
  }
}
