import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'TaskModel.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Tasks ("
          "id INTEGER PRIMARY KEY,"
          "heading TEXT,"
          "context TEXT,"
          "status INTEGER"
          ")");
    });
  }

  newTask(Task newTask) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Tasks");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Tasks (id,heading,context,status)"
        " VALUES (?,?,?,?)",
        [id, newTask.heading, newTask.context, newTask.status]);
    return raw;
  }

  changeStatus(Task task) async {
    final db = await database;
    Task status = Task(
        id: task.id,
        heading: task.heading,
        context: task.context,
        status: !task.status);
    var res = await db.update("Tasks", status.toMap(),
        where: "id = ?", whereArgs: [task.id]);
    return res;
  }

  updateTask(Task newTask) async {
    final db = await database;
    var res = await db.update("Tasks", newTask.toMap(),
        where: "id = ?", whereArgs: [newTask.id]);
    return res;
  }

  getTask(int id) async {
    final db = await database;
    var res = await db.query("Tasks", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Task.fromMap(res.first) : null;
  }

  Future<List<Task>> getBlockedTasks() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Task WHERE blocked=1");
    var res = await db.query("Tasks", where: "status = ? ", whereArgs: [1]);

    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    var res = await db.query("Tasks");
    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }

  deleteTasks(int id) async {
    final db = await database;
    return db.delete("Tasks", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Tasks");
  }
}
