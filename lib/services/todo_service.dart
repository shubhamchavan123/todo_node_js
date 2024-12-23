import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class TodoService {
  final String baseUrl = 'https://a212-116-74-176-243.ngrok-free.app/api/todos'; // Use your API base URL

  Future<List<Todo>> getTodos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<Todo> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(todo.toJson()),
    );
    if (response.statusCode == 201) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create todo');
    }
  }


  Future<void> createTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse('$baseUrl'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(todo.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create  todo');
    }
  }


  Future<void> updateTodo(String id, Todo todo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(todo.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}