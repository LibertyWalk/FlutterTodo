import 'package:flutter/material.dart';
import 'package:todo_app/models/Todo.dart';
import 'package:todo_app/database/TodoDatabase.dart';
import 'package:uuid/uuid.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  AddTodoScreenState createState() => new AddTodoScreenState();
}

class AddTodoScreenState extends State<AddTodoScreen> {


  static var uuid = new Uuid();
  Todo todo =
      new Todo(title: "", description: "", id: uuid.v4(), isExpanded: false);


  void navigateBack() {
    TodoDatabase db = new TodoDatabase();
    db.addTodo(todo);
    setState((){});
    Navigator.of(context).pop(todo);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add a new Todo"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.save),
            onPressed: () => navigateBack(),
          )
        ],
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Title",
              ),
              onChanged: (String input) => todo.title = input,
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Description",
              ),
              onChanged: (String input) => todo.description = input,
            ),
          ),
        ],
      ),
    );
  }
}
