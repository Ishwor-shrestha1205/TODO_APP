import 'package:flutter/material.dart';
import 'todo.dart'; // Make sure this model class exists with the necessary properties

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];

  void _addTodoItem(String title) {
    setState(() {
      _todos.add(Todo(title: title));
    });
  }

  void _toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }

  void _showAddTodoDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController _textFieldController = TextEditingController();
      return AlertDialog(
        title: Text('Add a new todo'),
        content: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(hintText: "Enter todo title"),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('ADD'),
            onPressed: () {
              if (_textFieldController.text.isNotEmpty) {
                _addTodoItem(_textFieldController.text);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_todos[index].title),
            leading: Checkbox(
              value: _todos[index].isDone,
              onChanged: (bool? value) {
                _toggleTodo(_todos[index], value!);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddTodoDialog,
      ),
    );
  }
}
