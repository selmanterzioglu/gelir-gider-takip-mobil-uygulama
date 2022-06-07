import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
        CREATE TABLE IF NOT EXISTS "accountant" (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        description	TEXT,
        cost INTEGER NOT NULL)
      """);
  }

  static Future<sql.Database> db() async {
    var path = join(await getDatabasesPath(), 'accountant.db');

    final database = openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
        """
          CREATE TABLE IF NOT EXISTS "accountant" (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          description	TEXT,
          cost INTEGER NOT NULL)
        """
        );
      },
      version: 1,
    );
    return database;
  }

  // Create new item (account progress)
  static Future<int> createItem(String description, double cost) async {
    final db = await SQLHelper.db();
    final data = {'description': description, 'cost': cost};
    final id = await db.insert('accountant', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('accountant', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('accountant', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String? description, double cost) async {
    final db = await SQLHelper.db();

    final data = {
      'description': description,
      'cost': cost,
    };

    final result = await db.update('accountant', data, where: "id = ?", whereArgs: [id]);

    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("accountant", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("[ERROR]: Something went wrong when deleting an item: $err");
    }
  }
}