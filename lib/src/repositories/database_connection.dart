import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'todo_db');
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }
}

_onCreate(Database db, int version) async {
  await db.execute(
      "CREATE TABLE categories(id INTEGER PRIMARY KEY,name TEXT,description TEXT)");
  await db.execute(
      "CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,description TEXT,category TEXT,date TEXT,isFinished INTEGER)");
}
