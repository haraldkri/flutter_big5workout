import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide ProfileScreen;
import 'package:flutter/material.dart';
import 'package:flutter_big5workout/interface/screens/app/layout.dart';
import 'package:flutter_big5workout/interface/screens/app/profile/profile_screen.dart';
import 'package:flutter_big5workout/interface/screens/app/statistic/statistic_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import 'app/training/training_screen.dart';
import 'home_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "rootNavigator");
final GlobalKey<NavigatorState> _shellNavigatorTrainingKey = GlobalKey<NavigatorState>(debugLabel: "shellNavigatorTraining");
final GlobalKey<NavigatorState> _shellNavigatorStatisticKey = GlobalKey<NavigatorState>(debugLabel: "shellNavigatorStatistic");
final GlobalKey<NavigatorState> _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: "shellNavigatorProfile");

final router = GoRouter(
  initialLocation: "/",
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: "/",
      name: "home",
      builder: (context, state) => Consumer<ApplicationState>(builder: (context, appState, _) => const HomeScreen()),
      routes: [
        GoRoute(
          path: 'sign-in',
          name: "sign-in",
          builder: (context, state) {
            return SignInScreen(
              actions: [
                // AccountDeletedAction((context, user) {
                //   context.pushNamed("sign-in");
                // }),
                ForgotPasswordAction(((context, email) {
                  context.pushNamed("forgot-password", queryParameters: {'email': email});
                })),
                AuthStateChangeAction(((context, state) {
                  final user =
                      switch (state) { SignedIn state => state.user, UserCreated state => state.credential.user, _ => null };
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(content: Text('Please check your email to verify your email address'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  context.pushReplacement('/training');
                })),
              ],
            );
          },
          routes: [
            GoRoute(
              path: 'forgot-password',
              name: 'forgot-password',
              builder: (context, state) {
                final arguments = state.uri.queryParameters;
                return ForgotPasswordScreen(
                  email: arguments['email'],
                  headerMaxExtent: 200,
                );
              },
            ),
          ],
        ),
      ],
    ),
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
  ],
);
