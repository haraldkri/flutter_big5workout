import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Widget defaultWidget;
  late bool selected;

  setUpAll(() {
    selected = false;
    defaultWidget = const ExerciseCard(
      title: "Pull Down",
      exerciseType: "Machine",
      muscleGroups: ["Latissimus", "Biceps"],
      previewImage: "assets/images/logo.svg",
      infoText:
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
      showSwapAction: false,
      showInfoAction: true,
      selected: selected,
      onTap: () {
        selected = true;
      },
    );
  });

  testWidgets('ExerciseCard should be displayed correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(defaultWidget);

    expect(find.byKey(const Key('exercise-card-default')), findsOneWidget);
    expect(find.text('Pull Down'), findsOneWidget);
    expect(find.text('Latissimus'), findsOneWidget);
    expect(find.text('Biceps'), findsOneWidget);
    expect(find.byKey(const Key('image-exercise-preview')), findsOneWidget);
    expect(find.byKey(const Key('button-swap-exercise')), findsNothing);
    expect(find.byKey(const Key('button-info-exercise')), findsOneWidget);
  });

  testWidgets('ExerciseCard buttons should function correctly', (WidgetTester tester) async {
    await tester.pumpWidget(defaultWidget);

    /// Tap on card
    expect(find.byKey(const Key('exercise-card-selected')), findsNothing);
    await tester.tap(find.byKey(const Key('exercise-card-default')));
    expect(find.byKey(const Key('exercise-card-selected')), findsOneWidget);

    /// Tap on info
    expect(find.byKey(const Key("info-view")), findsNothing);
    expect(find.text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr"), findsNothing);
    await tester.tap(find.byKey(const Key('button-info-exercise')));
    expect(find.byKey(const Key("info-view")), findsOneWidget);
    expect(find.text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr"), findsOneWidget);
  });
}
