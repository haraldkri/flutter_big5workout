import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../interface/data/training_data.dart';

final tableRecord = "workout_records";
final tableExerciseRecordId = "exercise_record_ids";
final tableExerciseRecord = "exercise_records";

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  Future<Database> database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal() {
    initDatabase();
  }

  initDatabase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'workout_records.db'),
      onCreate: (db, version) {
        db.execute(
          '''CREATE TABLE $tableRecord(
            id TEXT PRIMARY KEY,
            key TEXT,
            total_duration INTEGER,
            start_timestamp INTEGER,
            end_timestamp INTEGER)
          ''',
        );
        db.execute(
          '''CREATE TABLE $tableExerciseRecordId(
            id TEXT PRIMARY KEY,
            order_index INTEGER,
            start_timestamp INTEGER,
            end_timestamp INTEGER,
            record_id TEXT,
            FOREIGN KEY (record_id) REFERENCES $tableRecord (id) ON DELETE CASCADE)
          ''',
        );
        db.execute(
          '''CREATE TABLE $tableExerciseRecord(
            id TEXT PRIMARY KEY,
            key TEXT,
            variation TEXT,
            style TEXT,
            duration INTEGER,
            weight REAL,
            movement_times TEXT,
            record_id TEXT,
            FOREIGN KEY (record_id) REFERENCES $tableRecord (id) ON DELETE CASCADE)
          ''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertRecord(WorkoutRecord record) async {
    Database db = await database;
    await db.insert(tableRecord, record.toMap());
    for (var exerciseRecordId in record.exerciseRecordIds) {
      await db.insert(tableExerciseRecordId, exerciseRecordId.toMap()..['record_id'] = record.id);
    }
    for (var exercise in record.exercises) {
      await db.insert(tableExerciseRecord, exercise.toMap()..['record_id'] = record.id);
    }
    return 1;
  }

  Future<WorkoutRecord?> getRecord(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> recordData = await db.query(tableRecord, where: 'id = ?', whereArgs: [id]);
    if (recordData.isNotEmpty) {
      List<Map<String, dynamic>> exerciseRecordIdData =
          await db.query(tableExerciseRecordId, where: 'record_id = ?', whereArgs: [id]);
      List<Map<String, dynamic>> exerciseData = await db.query(tableExerciseRecord, where: 'record_id = ?', whereArgs: [id]);

      List<ExerciseRecordId> exerciseRecordIds = exerciseRecordIdData.map((data) => ExerciseRecordId.fromMap(data)).toList();
      List<ExerciseRecord> exercises = exerciseData.map((data) => ExerciseRecord.fromMap(data)).toList();

      return WorkoutRecord.fromMap(recordData.first, exerciseRecordIds, exercises);
    }
    return null;
  }
}
