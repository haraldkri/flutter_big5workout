import 'package:flutter/material.dart';

class WorkoutStartScreen extends StatelessWidget {
  final String workoutId;
  const WorkoutStartScreen({super.key, required this.workoutId});

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key("screen-start-workout"),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Start Workout Screen'),
        ],
      ),
    );
  }
}
