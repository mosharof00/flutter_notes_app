import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note_model.dart';


class DBHelper {
  static Database? _database;

  Future<Database?> get db async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDataBase();
    return _database;
  }

  initDataBase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,subtitle TEXT, date DATE)');
  }

  Future<Note> insertData(Note note) async {
    var dbclient = await db;
    await dbclient!.insert('notes', note.toMap());
    return note;
  }

  Future<List<Note>> getCartData() async {
    var dbclient = await db;
    final List<Map<String, Object?>> queryresult =
        await dbclient!.query("notes");
    return queryresult.map((e) => Note.fromMap(e)).toList();
  }

  Future<int> delete(dynamic id) async {
    var dbClient = await db;
    return await dbClient!.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatedQuentity(Note cart) async {
    var dbClient = await db;
    return await dbClient!
        .update('notes', cart.toMap(), where: 'id= ?', whereArgs: [cart.id]);
  }
}
