import 'package:flutter_mal/models/history_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDatabase();
      return _database!;
    }
  }

  Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), 'mal_db.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
      )
    ''');
  }

  Future<int> addHistory(HistoryModel item) async {
    // print(item.name);
    if (item.name == "") {
      return 0;
    }
    final Database db = await database;
    final isUnique =
        await db.query("history", where: 'name = ?', whereArgs: [item.name]);
    if (isUnique.isNotEmpty) {
      return 0;
    }
    return await db.insert('history', {"name": item.name});
  }

  Future<int> deleteHistory(int id) async {
    final Database db = await database;
    return await db.delete('history', where: "id = ?", whereArgs: [id]);
  }

  Future<List<HistoryModel>> getHistory() async {
    final Database db = await database;
    final data = await db.query("history");
    if (data.isNotEmpty) {
      // print(data);
      return data
          .map((e) =>
              HistoryModel(name: e["name"].toString(), id: e["id"] as int))
          .toList();
    } else {
      return [];
    }
  }
}
