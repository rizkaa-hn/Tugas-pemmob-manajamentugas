import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:todo_riverpod/common/models/task.dart';

class DBHelper {
  // Database to send sql commands, created during [openDatabase]
  static Future<void> createTables(sql.Database database) async {
    await database.execute(
      // xecute an SQL query with no return value.
      "CREATE TABLE items("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "title STRING, desc TEXT, date STRING, "
      "startTime STRING, endTime STRING, "
      "remind INTEGER, repeat STRING, "
      "isCompleted INTEGER)",
    );
    await database.execute("CREATE TABLE user("
        "id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0, "
        "isVerified INTEGER DEFAULT 0)");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('todo.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(Task task) async {
    final db = await DBHelper.db();

    final id = await db.insert('items', task.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

// Create user
  static Future<int> createuser(int isVerified) async {
    final db = await DBHelper.db();

    final data = {
      'id': 1,
      'isVerified': isVerified,
    };

    final id = await db.insert('user', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Get user
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await DBHelper.db();
    return db.query('user', orderBy: 'id');
  }



  static Future<void> logout(int id) async {
    final db = await DBHelper.db();
    try {
      db.delete('user', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Unable to delete: $e");
    }
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DBHelper.db();
    return db.query('items', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DBHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String title, String desc,
      int isCompleted, String date, String startTime, String endTime) async {
    final db = await DBHelper.db();
    final data = {
      'title': title,
      'desc': desc,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime
    };

    final results =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);

    return results;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DBHelper.db();
    try {
      db.delete('items', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Unable to delete: $e");
    }
  }
}
