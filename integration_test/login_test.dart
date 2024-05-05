import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_big5workout/firebase_options.dart';
import 'package:flutter_big5workout/interface/app.dart';
import 'package:flutter_big5workout/interface/app_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

import 'mock_app_state.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  group('login to the app as authenticated user', () {
    late Widget app;
    setUpAll(() {
      app = ChangeNotifierProvider<ApplicationState>(
        create: (context) => MockApplicationState(),
        builder: (context, child) => App(),
      );
    });

    testWidgets('An authenticated user should open the app and see the training page', (tester) async {
      // Load app widget.
      await tester.pumpWidget(app);

      // Pump frames until no animations are running
      await tester.pumpAndSettle();

      // Complete bottom nav bar should be visible
      expect(find.byKey(const Key("bottom-nav-bar")), findsOneWidget);
      expect(find.byKey(const Key("nav-item-training")), findsOneWidget);
      expect(find.byKey(const Key("nav-item-statistic")), findsOneWidget);
      expect(find.byKey(const Key("nav-item-profile")), findsOneWidget);

      // The training screen should be visible initially
      expect(find.byKey(const Key("screen-training")), findsOneWidget);
    });
  });
}
