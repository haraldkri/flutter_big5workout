// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_big5workout/interface/app.dart';
import 'package:flutter_big5workout/interface/app_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../integration_test/mock_app_state.dart';

void main() {
  testWidgets('Landing Page should be visible when starting the app', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ChangeNotifierProvider<ApplicationState>(
      create: (context) => MockApplicationState(),
      builder: (context, child) => App(),
    ));

    expect(find.text('Get started'), findsOneWidget);
  });
}
