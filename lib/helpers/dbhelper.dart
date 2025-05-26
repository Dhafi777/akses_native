import 'dart:async';
import 'package:akses_fitur_native/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database> db() async {
    String path = await getDatabasesPath();
    final database = openDatabase(
      join(path, 'contact.db'),
      onCreate: (database, version) async {
        await _createTable(database);
      },
      version: 1,
    );
    return database;
  }

  static Future<void> _createTable(Database db) async {
    await db.execute(
      """
      CREATE TABLE contact (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT
      )
      """,
    );
  }

  static Future<List<Contact>> getContactList() async {
    final Database db = await DbHelper.db();
    final List<Map<String, dynamic>> maps =
        await db.query('contact', orderBy: 'name');

    return List.generate(maps.length, (i) {
      return Contact.fromMap(maps[i]);
    });
  }

  static Future<int> insert(Contact contact) async {
    final db = await DbHelper.db();
    int count = await db.insert(
      'contact',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return count;
  }

  static Future<int> update(Contact contact) async {
    final db = await DbHelper.db();
    int count = await db.update(
      'contact',
      contact.toMap(),
      where: 'id=?',
      whereArgs: [contact.id],
    );
    return count;
  }

  static Future<int> delete(int id) async {
    final db = await DbHelper.db();
    int count = await db.delete(
      'contact',
      where: 'id=?',
      whereArgs: [id],
    );
    return count;
  }
}
