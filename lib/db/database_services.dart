import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class DatabaseServices {
  DatabaseServices._();

  static final DatabaseServices db = DatabaseServices._();

  static Database? _database;

  Future<Database?> get database async {
    if(_database != null){
      return _database;
    }
    _database = await initDB();

    return _database;
  }

  initDB () async {
    return await openDatabase(
      join(await getDatabasesPath(), 'simple_notes.db'),
      version: 1,
      onCreate:  (db, version) async {
        db.execute('''
CREATE TABLE notes(id INTERGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT, createdAt DATE)''');
      }
    );
  }
  addNewNote(Note note) async {
    final db = await database;
    db!.insert('notes', note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace, );

  }
  Future<dynamic>getAllNotes() async {
    final db = await database;
    var res = await db!.query('notes');

    if(res.isEmpty){
      return null;
    } else {
      var result = res.toList();
      return result.isNotEmpty ? result : null;
    }
  }
  Future<int> updateNote(Note note) async {
    final db = await database;

    var result = await db!.rawUpdate('''
UPDATE notes SET title = "${note.title}", desc = "${note.desc}", createdAt = "${note.createdAt}" WHERE id = ${note.id}''');
return result;
  }

  Future<int> deleteNote(int id) async {
    final db = await database;

    int count = await db!.rawDelete('''DELETE FROM notes WHERE id = ?''', [id]);
    return count;
  }
}
