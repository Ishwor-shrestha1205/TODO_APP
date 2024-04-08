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

  void _addOrEditTodoItem({required bool isEditing, String title = '', required int index}) {
    TextEditingController _textFieldController = TextEditingController(text: title);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit todo' : 'Add a new todo'),
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
              child: Text(isEditing ? 'UPDATE' : 'ADD'),
              onPressed: () {
                setState(() {
                  if (isEditing) {
                    _todos[index].title = _textFieldController.text;
                  } else {
                    _todos.add(Todo(title: _textFieldController.text));
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todos.removeAt(index);
    });
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
                setState(() {
                  _todos[index].isDone = value!;
                });
              },
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _addOrEditTodoItem(isEditing: true, title: _todos[index].title, index: index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteTodoItem(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addOrEditTodoItem(isEditing: false, index: -1), // -1 indicates adding a new item
      ),
    );
  }
}