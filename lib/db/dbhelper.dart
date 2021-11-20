import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:noter/models/note.model.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "notes.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Note(id INTEGER PRIMARY KEY, text TEXT, created_at TEXT )");
  }

  void saveNote(Note note) async {
    var dbClient = await db;
    return await dbClient?.transaction((txn) async {
      await txn.rawInsert('INSERT INTO Note(text, created_at ) VALUES(?,?)',
          [note.text, DateTime.now().toString()]);
    });
  }

  Future<List<Note>> getNotes() async {
    var dbClient = await db;
    if (dbClient != null) {
      List<Map> list = await dbClient.rawQuery('SELECT * FROM Note');
      List<Note> notes = [];
      for (int i = 0; i < list.length; i++) {
        notes.add(Note(text: list[i]['text']));
      }
      print(notes.length);
      return notes;
    } else {
      return [];
    }
  }
}
