import 'package:flutter/cupertino.dart';
import 'package:flutter_big5workout/interface/screens/app/layout.dart';
import 'package:flutter_big5workout/interface/screens/app/profile/profile_screen.dart';
import 'package:flutter_big5workout/interface/screens/app/statistic/statistic_screen.dart';
import 'package:go_router/go_router.dart';

import 'app/training/training_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "rootNavigator");
final GlobalKey<NavigatorState> _shellNavigatorTrainingKey = GlobalKey<NavigatorState>(debugLabel: "shellNavigatorTraining");
final GlobalKey<NavigatorState> _shellNavigatorStatisticKey = GlobalKey<NavigatorState>(debugLabel: "shellNavigatorStatistic");
final GlobalKey<NavigatorState> _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: "shellNavigatorProfile");

final router = GoRouter(initialLocation: "home", navigatorKey: _rootNavigatorKey, routes: [
  StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppLayout(navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorTrainingKey,
          routes: [
            GoRoute(
              path: "/training",
              name: "training",
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: TrainingScreen());
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorStatisticKey,
          routes: [
            GoRoute(
              path: "/statistic",
              name: "statistic",
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: StatisticScreen());
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            GoRoute(
              path: "/profile",
              name: "profile",
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: ProfileScreen());
              },
            )
          ],
        )
      ])
]);
