import 'package:flutter/material.dart';
import '../services/todo_service.dart';
import '../models/todo.dart';

class UpdateTodoScreen extends StatelessWidget {
  final Todo todo;
  final TextEditingController _titleController;
  final TextEditingController _bodyController;
  final TodoService _todoService = TodoService();

  UpdateTodoScreen({required this.todo})
      : _titleController = TextEditingController(text: todo.title),
        _bodyController = TextEditingController(text: todo.body);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedTodo = Todo(
                  id: todo.id,
                  title: _titleController.text,
                  body: _bodyController.text,
                  completed: todo.completed,
                );
                _todoService.updateTodo(todo.id, updatedTodo).then((_) {
                  Navigator.pop(context);
                });
              },
              child: Text('Update Todo'),
            ),
          ],
        ),
      ),
    );
  }
}