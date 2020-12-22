import 'dart:io';
import 'package:myNotes/models/note.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper databaseHelper = DatabaseHelper._();
  Database _database;

  static const String DB_NAME = "workshop.db";
  static const String DB_PATH = "assets/database/" + DB_NAME;

  static const String TABLE_NOTES = "notes";
  static const String COL_ID = "note_id";
  static const String COL_TITLE = "note_title";
  static const String COL_DESC = "note_desc";
  static const String COL_TIMESTAMP = "note_created_at";
  static const String COL_PRIORITY = "note_priority";
  static const String COL_ISDONE = "note_is_done";

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    var directory = await getDatabasesPath();
    String path = join(directory, DB_NAME);
    var exists = await databaseExists(path);
    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData byteData = await rootBundle.load(DB_PATH);
      List<int> bytes = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
    var db = await openDatabase(path, readOnly: false);
    return db;
  }

  Future<List<Note>> fetchAllNotes() async {
    final db = await database;
    var response = await db.query(TABLE_NOTES);
    List<Note> list = response.map((c) => Note.fromMap(c)).toList();
    return list;
  }

  insertNote(Note note) async {
    final db = await database;
    return await db.rawInsert(
        'INSERT INTO $TABLE_NOTES ($COL_TITLE, $COL_DESC, $COL_TIMESTAMP, $COL_PRIORITY, $COL_ISDONE)'
        'VALUES (?, ?, ?, ?, ?)',
        [
          note.title,
          note.description,
          note.timestamp,
          note.priority,
          note.isDone
        ]);
  }

  setAsDone(int noteID) async {
    final db = await database;
    return await db.rawUpdate(
        'UPDATE $TABLE_NOTES SET $COL_ISDONE = 1 WHERE $COL_ID = $noteID');
  }

  setAsInProgress(int noteID) async {
    final db = await database;
    return await db.rawUpdate(
        'UPDATE $TABLE_NOTES SET $COL_ISDONE = 0 WHERE $COL_ID = $noteID');
  }

  Future close() async {
    var db = await database;
    return db.close();
  }
}
