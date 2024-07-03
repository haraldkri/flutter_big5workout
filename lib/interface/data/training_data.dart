import 'dart:convert';
import 'dart:io';

class TrainingData {
  final List<WorkoutRecord> records;

  TrainingData(this.records);

  factory TrainingData.fromJson(Map<String, dynamic> json) {
    var records = (json['records']['workouts'] as List).map((recordJson) => WorkoutRecord.fromJson(recordJson)).toList();
    return TrainingData(records);
  }

  factory TrainingData.fromFile(String filePath) {
    final file = File(filePath);
    final json = jsonDecode(file.readAsStringSync());
    return TrainingData.fromJson(json);
  }
}

class ExerciseRecord {
  final String id;
  final String key;
  final String variation;
  final String style;
  final int duration;
  final double weight;
  final Map<String, int> movementTimes;

  ExerciseRecord(
    this.id,
    this.key,
    this.variation,
    this.style,
    this.duration,
    this.weight,
    this.movementTimes,
  );

  factory ExerciseRecord.fromJson(Map<String, dynamic> json) {
    return ExerciseRecord(
      json['id'],
      json['key'],
      json['variation'],
      json['style'],
      json['duration'],
      json['weight'].toDouble(),
      Map<String, int>.from(json['movement_times']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'variation': variation,
      'style': style,
      'duration': duration,
      'weight': weight,
      'movement_times': jsonEncode(movementTimes),
    };
  }

  static ExerciseRecord fromMap(Map<String, dynamic> map) {
    return ExerciseRecord(
      map['id'],
      map['key'],
      map['variation'],
      map['style'],
      map['duration'],
      map['weight'].toDouble(),
      Map<String, int>.from(jsonDecode(map['movement_times'])),
    );
  }
}

class ExerciseRecordId {
  final String id;
  final int orderIndex;
  final int startTimestamp;
  final int endTimestamp;

  ExerciseRecordId(
    this.id,
    this.orderIndex,
    this.startTimestamp,
    this.endTimestamp,
  );

  factory ExerciseRecordId.fromJson(Map<String, dynamic> json) {
    return ExerciseRecordId(
      json['id'],
      json['order_index'],
      json['start_timestamp'],
      json['end_timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_index': orderIndex,
      'start_timestamp': startTimestamp,
      'end_timestamp': endTimestamp,
    };
  }

  static ExerciseRecordId fromMap(Map<String, dynamic> map) {
    return ExerciseRecordId(
      map['id'],
      map['order_index'],
      map['start_timestamp'],
      map['end_timestamp'],
    );
  }
}

class WorkoutRecord {
  final String id;
  final String key;
  final int totalDuration;
  final int startTimestamp;
  final int endTimestamp;
  final List<ExerciseRecordId> exerciseRecordIds;
  final List<ExerciseRecord> exercises;

  WorkoutRecord(
    this.id,
    this.key,
    this.totalDuration,
    this.startTimestamp,
    this.endTimestamp,
    this.exerciseRecordIds,
    this.exercises,
  );

  factory WorkoutRecord.fromJson(Map<String, dynamic> json) {
    var exerciseRecordIds = (json['exercise_record_ids'] as List)
        .map((exerciseRecordIdJson) => ExerciseRecordId.fromJson(exerciseRecordIdJson))
        .toList();
    var exercises = (json['exercises'] as List).map((exerciseJson) => ExerciseRecord.fromJson(exerciseJson)).toList();

    return WorkoutRecord(
      json['id'],
      json['key'],
      json['total_duration'],
      json['start_timestamp'],
      json['end_timestamp'],
      exerciseRecordIds,
      exercises,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'total_duration': totalDuration,
      'start_timestamp': startTimestamp,
      'end_timestamp': endTimestamp,
    };
  }

  static WorkoutRecord fromMap(
      Map<String, dynamic> map, List<ExerciseRecordId> exerciseRecordIds, List<ExerciseRecord> exercises) {
    return WorkoutRecord(
      map['id'],
      map['key'],
      map['total_duration'],
      map['start_timestamp'],
      map['end_timestamp'],
      exerciseRecordIds,
      exercises,
    );
  }
}
