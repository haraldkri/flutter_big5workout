/*
* Generated with help of ChatGPT4o
* https://chatgpt.com/share/f18fddb4-0c7e-4d67-a518-140e1b19f250
* */

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


class TrainingData {
  final List<Muscle> muscles;
  final List<Exercise> exercises;

  TrainingData(this.muscles, this.exercises);

  factory TrainingData.fromJson(Map<String, dynamic> json) {
    var muscles = (json['muscles'] as List)
        .map((muscleName) => Muscle(muscleName))
        .toList();
    var exercises = (json['exercises'] as List)
        .map((exerciseJson) => Exercise.fromJson(exerciseJson))
        .toList();

    return TrainingData(muscles, exercises);
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
      print('  Primary Muscles: ${variation.primaryMuscles.join(', ')}');
      print('  Supporting Muscles: ${variation.supportingMuscles.join(', ')}');
      print('  Description (en): ${variation.description['en']}');
      print('  Description (de): ${variation.description['de']}');
      print('  -');
    }
    print('\n');
  }
}

