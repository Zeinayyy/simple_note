import 'package:hive/hive.dart';

import '../models/note.dart';

class DatabaseService {
  final String boxName = 'notesBox';
  Future<void> addNote(Note note) async {
    final box = await Hive.openBox(boxName);
    await box.add(note);
  }

  Future<List<Note>> getAllNotes() async {
    final box = await Hive.openBox(boxName);
    return box.values.toList().cast<Note>();
  }

  Future<void> updateNote(Note note) async {
    final box = await Hive.openBox(boxName);
    await box.put(note.key, note);
  }

  Future<void> deleteNote(Note note) async {
    final box = await Hive.openBox(boxName);
    await box.delete(note.key);
  }
}
