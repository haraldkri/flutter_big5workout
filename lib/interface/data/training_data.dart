import 'dart:convert';
import 'dart:io';

class Muscle {
  final String name;

  Muscle(this.name);

  factory Muscle.fromJson(Map<String, dynamic> json) {
    return Muscle(json['name']);
  }
}

class Variation {
  final String key;
  final List<String> primaryMuscles;
  final List<String> supportingMuscles;
  final Map<String, String> description;

  Variation(this.key, this.primaryMuscles, this.supportingMuscles, this.description);

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      json['key'],
      List<String>.from(json['primary_muscles']),
      List<String>.from(json['supporting_muscles']),
      Map<String, String>.from(json['description']),
    );
  }
}

class Exercise {
  final String key;
  final Map<String, String> name;
  final List<Variation> variations;
  final List<String> possibleStyles;

  Exercise(this.key, this.name, this.variations, this.possibleStyles);

  factory Exercise.fromJson(Map<String, dynamic> json) {
    var variations = (json['variations'] as List)
        .map((variationJson) => Variation.fromJson(variationJson))
        .toList();

    return Exercise(
      json['key'],
      Map<String, String>.from(json['name']),
      variations,
      List<String>.from(json['possible_styles']),
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
}

class WorkoutExercise {
  final String key;
  final String variation;
  final String style;

  WorkoutExercise(this.key, this.variation, this.style);

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) {
    return WorkoutExercise(
      json['key'],
      json['variation'],
      json['style'],
    );
  }
}

class Workout {
  final String key;
  final Map<String, String> description;
  final List<WorkoutExercise> exercises;

  Workout(this.key, this.description, this.exercises);

  factory Workout.fromJson(Map<String, dynamic> json) {
    var exercises = (json['exercises'] as List)
        .map((exerciseJson) => WorkoutExercise.fromJson(exerciseJson))
        .toList();

    return Workout(
      json['key'],
      Map<String, String>.from(json['description']),
      exercises,
    );
  }
}

class Record {
  final String id;
  final String key;
  final int totalDuration;
  final int startTimestamp;
  final int endTimestamp;
  final List<ExerciseRecordId> exerciseRecordIds;
  final List<ExerciseRecord> exercises;

  Record(
      this.id,
      this.key,
      this.totalDuration,
      this.startTimestamp,
      this.endTimestamp,
      this.exerciseRecordIds,
      this.exercises,
      );

  factory Record.fromJson(Map<String, dynamic> json) {
    var exerciseRecordIds = (json['exercise_record_ids'] as List)
        .map((exerciseRecordIdJson) => ExerciseRecordId.fromJson(exerciseRecordIdJson))
        .toList();
    var exercises = (json['exercises'] as List)
        .map((exerciseJson) => ExerciseRecord.fromJson(exerciseJson))
        .toList();

    return Record(
      json['id'],
      json['key'],
      json['total_duration'],
      json['start_timestamp'],
      json['end_timestamp'],
      exerciseRecordIds,
      exercises,
    );
  }
}

class TrainingData {
  final List<Muscle> muscles;
  final List<Exercise> exercises;
  final List<Workout> workouts;
  final List<Record> records;

  TrainingData(this.muscles, this.exercises, this.workouts, this.records);

  factory TrainingData.fromJson(Map<String, dynamic> json) {
    var muscles = (json['muscles'] as List)
        .map((muscleName) => Muscle(muscleName))
        .toList();
    var exercises = (json['exercises'] as List)
        .map((exerciseJson) => Exercise.fromJson(exerciseJson))
        .toList();
    var workouts = (json['workouts'] as List)
        .map((workoutJson) => Workout.fromJson(workoutJson))
        .toList();
    var records = (json['records']['workouts'] as List)
        .map((recordJson) => Record.fromJson(recordJson))
        .toList();

    return TrainingData(muscles, exercises, workouts, records);
  }

  factory TrainingData.fromFile(String filePath) {
    final file = File(filePath);
    final json = jsonDecode(file.readAsStringSync());
    return TrainingData.fromJson(json);
  }
}

void main() {
  // Example usage:
  var trainingData = TrainingData.fromFile('${Directory.current.path}/assets/data/training_data.json');

  // Print out all exercises
  for (var exercise in trainingData.exercises) {
    print('Exercise: ${exercise.name['en']}');
    for (var variation in exercise.variations) {
      print('  Variation: ${variation.key}');
      print('  Styles: ${exercise.possibleStyles.join(', ')}');
      print('  Primary Muscles: ${variation.primaryMuscles.join(', ')}');
      print('  Supporting Muscles: ${variation.supportingMuscles.join(', ')}');
      print('  Description (en): ${variation.description['en']}');
      print('  Description (de): ${variation.description['de']}');
      print('  -');
    }
    print('##########################################################################################\n');
  }

  // Print out all workouts
  for (var workout in trainingData.workouts) {
    print('Workout: ${workout.key}');
    print('  Description (en): ${workout.description['en']}');
    print('  Description (de): ${workout.description['de']}');
    for (var exercise in workout.exercises) {
      print('  ->Exercise Key: ${exercise.key}');
      print('    Variation: ${exercise.variation}');
      print('    Style: ${exercise.style}');
    }
    print('##########################################################################################\n');
  }

  // Print out all records
  for (var record in trainingData.records) {
    print('Record ID: ${record.id}');
    print('  Workout Key: ${record.key}');
    print('  Total Duration: ${record.totalDuration}');
    print('  Start Timestamp: ${record.startTimestamp}');
    print('  End Timestamp: ${record.endTimestamp}');
    for (var exerciseRecordId in record.exerciseRecordIds) {
      print('  ->Exercise Record: ${exerciseRecordId.id}');
      print('    Order Index: ${exerciseRecordId.orderIndex}');
      print('    Start Timestamp: ${exerciseRecordId.startTimestamp}');
      print('    End Timestamp: ${exerciseRecordId.endTimestamp}');
    }
    for (var exerciseRecord in record.exercises) {
      print('   -->Exercise Record ID: ${exerciseRecord.id}');
      print('      Key: ${exerciseRecord.key}');
      print('      Variation: ${exerciseRecord.variation}');
      print('      Style: ${exerciseRecord.style}');
      print('      Duration: ${exerciseRecord.duration}');
      print('      Weight: ${exerciseRecord.weight}');
      print('      Movement Times: ${exerciseRecord.movementTimes}');
    }
    print('##########################################################################################\n');
  }
}