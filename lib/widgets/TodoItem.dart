import 'package:flutter/material.dart';
import 'package:todo_app/models/Todo.dart';
import 'package:todo_app/database/TodoDatabase.dart';

class TodoItem extends StatefulWidget {

  final Todo todo;
  final Function onDelete;

  TodoItem(this.todo, {this.onDelete});

  @override
  TodoItemState createState() => new TodoItemState();
}

class TodoItemState extends State<TodoItem> {
  Todo todoState;
  TodoDatabase db = new TodoDatabase();

  @override
  void initState(){
    super.initState();
    todoState = widget.todo;
  }

  @override
  Widget build(BuildContext context) {
    return new ExpansionTile(
      initiallyExpanded: todoState.isExpanded ?? false,
      onExpansionChanged: (expanded) => todoState.isExpanded = expanded,
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.all(10.0),
          child: new RichText(
            text: new TextSpan(
              text: todoState.description,
              style: new TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w200,
                color: Colors.black
              )
            ),
          ),
        )
      ],
      leading: new Icon(
        Icons.alarm
      ),
      trailing: new IconButton(
        icon: new Icon(Icons.delete),
        onPressed: () => widget.onDelete(todoState.id)
      ),
      title: new RichText(
        text:  new TextSpan(
          text: todoState.title,
          style: new TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            color: Colors.black
          ),
        ),
      ),
    );
  }
}
