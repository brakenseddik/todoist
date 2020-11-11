import 'package:sqflite/sqflite.dart';
import 'package:todoist/src/repositories/database_connection.dart';

class Repository {
  DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  save(table, data) async {
    var conn = await database;
    return await conn.insert(table, data);
  }

  getALL(table) async {
    var conn = await database;
    return await conn.query(table);
  }
}
