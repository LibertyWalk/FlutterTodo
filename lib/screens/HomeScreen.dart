import 'package:flutter/material.dart';
import 'package:todo_app/models/Todo.dart';
import 'package:todo_app/database/TodoDatabase.dart';
import 'package:todo_app/widgets/TodoItem.dart';
import 'package:todo_app/screens/AddTodoScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Todo> todos = new List();

  @override
  void initState() {
    super.initState();
    populateTodos();
  }

  void populateTodos() async {
    TodoDatabase db = new TodoDatabase();
    db.getAllTodos().then((newTodos) {
      setState(() => todos = newTodos);
    });
  }

  void openAddTodoScreen() async {
    Navigator
        .push(context,
            new MaterialPageRoute(builder: (context) => new AddTodoScreen()))
        .then((b) {
      populateTodos();
    });
  }

  void clearDb() async {
    TodoDatabase db = new TodoDatabase();
    db.clearDb();
    populateTodos();
  }

  void deleteTodo(String id) {
    TodoDatabase db = new TodoDatabase();
    db.deleteTodo(id);
    populateTodos();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Todo App"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.delete),
            onPressed: () => clearDb(),
          )
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              child: new ListView.builder(
                padding: new EdgeInsets.all(10.0),
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  return new TodoItem(todos[index], onDelete: (id) {
                    TodoDatabase db = new TodoDatabase();
                    print("ID: " + id);
                    db.deleteTodo(id).then((b) {
                      populateTodos();
                    });
                  });
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add), onPressed: () => openAddTodoScreen()),
    );
  }
}
