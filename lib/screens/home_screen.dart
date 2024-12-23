import 'package:flutter/material.dart';
import '../services/todo_service.dart';
import '../models/todo.dart';
import 'add_todo_screen.dart';
import 'update_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodoService _todoService = TodoService();
  late Future<List<Todo>> _todos;

  @override
  void initState() {
    super.initState();
    _todos = _todoService.getTodos();
  }

  void _toggleCompleted(Todo todo) {
    Todo updatedTodo = Todo(
      id: todo.id,
      title: todo.title,
      body: todo.body,
      completed: !todo.completed,
    );
    _todoService.updateTodo(todo.id, updatedTodo).then((_) {
      setState(() {
        _todos = _todoService.getTodos();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: _todos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No todos available.'));
          }

          final todos = snapshot.data!;

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.body),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: todo.completed,
                      onChanged: (value) {
                        _toggleCompleted(todo);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _todoService.deleteTodo(todo.id).then((_) {
                          setState(() {
                            _todos = _todoService.getTodos();
                          });
                        });
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateTodoScreen(todo: todo),
                    ),
                  ).then((_) {
                    setState(() {
                      _todos = _todoService.getTodos();
                    });
                  });
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoScreen(),
            ),
          ).then((_) {
            setState(() {
              _todos = _todoService.getTodos();
            });
          });
        },
      ),
    );
  }
}