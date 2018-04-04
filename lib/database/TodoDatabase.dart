import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/Todo.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class TodoDatabase {
  TodoDatabase();
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: createDatabase);
    return theDb;
  }

  void createDatabase(Database db, int version) async {
    await db.execute("CREATE TABLE Todos(id STRING PRIMARY KEY, title TEXT, description TEXT)");

    print("Database was Created!");
  }

  Future<List<Todo>> getAllTodos() async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("Todos");
    print(res);
    return res.map((map) => new Todo(title: map["title"], description: map["description"], id: map["id"])).toList();
  }

  Future<Todo> getTodo(String id) async {
    var dbClient = await db;
    var res = await dbClient.query("Todos", where: "id = ?", whereArgs: [id]);
    if (res.length == 0) return null;
    return new Todo.fromDb(res[0]);
  }

  Future<int> addTodo(Todo todo) async {
    var dbClient = await db;
    int res = await dbClient.insert("Todos", todo.toMap());
    return res;
  }

  Future<int> updateTodo(Todo todo) async {
    var dbClient = await db;
    int res = await dbClient.update(
      "Todos",
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id]);
      return res;
  }

  Future<int> deleteTodo(String id) async {
    var dbClient = await db;
    var res = await dbClient.delete(
      "Todos",
      where: "id = ?",
      whereArgs: [id]);
      print("Deleted item");
      return res;
  }

  Future<int> clearDb() async {
    var dbClient = await db;
    var res = await dbClient.execute("DELETE from Todos");
      print("Deleted db contents");
      return res;
  }
}