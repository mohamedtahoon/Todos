class TodoResponseModel {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  TodoResponseModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.completed});

  factory TodoResponseModel.fromJson(Map<String, dynamic> json) {
    return TodoResponseModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'completed': completed,
    };
  }
}
