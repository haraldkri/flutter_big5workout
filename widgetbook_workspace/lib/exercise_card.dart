import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:flutter_big5workout/interface/widgets/exercise_card.dart';

@widgetbook.UseCase(name: 'Default', type: ExerciseCard)
Widget buildExerciseCardUseCase(BuildContext context) {
  bool selected = false;
  return ExerciseCard(
    title: "Pull Down",
    exerciseType: "Machine",
    muscleGroups: const ["Latissimus", "Biceps"],
    previewImage: "assets/images/logo.svg",
    infoText:
        "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
    showSwapAction: false,
    showInfoAction: true,
    selected: selected,
    onTap: () {
      selected = !selected;
    },
  );
}
