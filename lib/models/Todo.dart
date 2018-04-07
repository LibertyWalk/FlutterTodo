import 'package:meta/meta.dart';

class Todo {
  String title;
  String description;
  String id;
  bool isExpanded;

  Todo({
    @required this.title,
    @required this.id,
    this.description,
    this.isExpanded
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    return map;
  }

  Todo.fromDb(Map map)
      : title = map["title"],
        id = map["id"],
        description = map["description"].toString();
}