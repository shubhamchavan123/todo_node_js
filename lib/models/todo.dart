class Todo {
  final String id;
  final String title;
  final String body;
  final bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.body,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['_id'],
      title: json['title'],
      body: json['body'],
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'completed': completed,
    };
  }
}