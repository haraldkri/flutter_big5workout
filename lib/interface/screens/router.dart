import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide ProfileScreen;
import 'package:flutter/material.dart';
import 'package:flutter_big5workout/interface/screens/app/layout.dart';
import 'package:flutter_big5workout/interface/screens/app/profile/profile_screen.dart';
import 'package:flutter_big5workout/interface/screens/app/statistic/statistic_screen.dart';
import 'package:flutter_big5workout/interface/screens/app/training/training_screen.dart';
import 'package:flutter_big5workout/interface/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

import 'app/training/exercise_result_screen.dart';
import 'app/training/exercise_start_screen.dart';
import 'app/training/exercise_timer_screen.dart';
import 'app/training/workout_start_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "rootNavigator");
final GlobalKey<NavigatorState> _shellNavigatorTrainingKey = GlobalKey<NavigatorState>(debugLabel: "shellNavigatorTraining");
final GlobalKey<NavigatorState> _shellNavigatorStatisticKey = GlobalKey<NavigatorState>(debugLabel: "shellNavigatorStatistic");
final GlobalKey<NavigatorState> _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: "shellNavigatorProfile");

GoRouter getRouter(bool isUserLoggedIn) => GoRouter(
      initialLocation: !isUserLoggedIn ? '/' : '/training',
      navigatorKey: _rootNavigatorKey,
      onException: (context, state, router) {
        context.goNamed("home");
      },
      routes: [
        GoRoute(
          path: "/",
          name: "home",
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'sign-in',
              name: "sign-in",
              redirect: (context, state) {
                if (isUserLoggedIn) return "/training";
                return null;
              },
              builder: (context, state) {
                return SignInScreen(
                  oauthButtonVariant: OAuthButtonVariant.icon_and_text,
                  actions: [
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
                      context.goNamed('training');
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
                  /// The training route should show a list of all workouts that the user can choose from. If only one workout exists,
                  /// redirect to that workout immediately.
                  GoRoute(
                      path: "/training",
                      name: "training",
                      redirect: (context, state) {
                        // TODO implement workoutIds fetch
                        final workoutIds = ["default workout"];

                        if (workoutIds.length == 1) return "training/${workoutIds.first}";
                        return null;
                      },
                      pageBuilder: (context, state) {
                        return const NoTransitionPage(child: TrainingScreen());
                      },
                      routes: [
                        GoRoute(
                          path: "/:workoutId",
                          name: "training-workout",
                          pageBuilder: (context, state) {
                            /// In this route all exercises of the workout are displayed.
                            /// The purpose of this route is to make the user select an exercise and start the training.
                            return const NoTransitionPage(child: WorkoutStartScreen());
                          },
                          routes: [
                            GoRoute(
                                path: "/:exerciseId",
                                name: "training-exercise",
                                redirect: (context, state) => "${state.fullPath}/start",
                                routes: [
                                  GoRoute(
                                    path: "/start",
                                    name: "training-exercise-overview",
                                    pageBuilder: (context, state) {
                                      /// In this route information to do the exercise is provided, e.g. Exercise name,
                                      /// last weight, last duration and a way to start the exercise.
                                      /// The purpose of the route is for the user to start the exercise.
                                      return const NoTransitionPage(child: ExerciseStartScreen());
                                    },
                                  ),
                                  GoRoute(
                                    path: "/timer",
                                    name: "training-exercise-timer",
                                    pageBuilder: (context, state) {
                                      /// This route is displayed when the user started the exercise.
                                      /// In this route the remaining time until the duration goal is displayed.
                                      /// The purpose of the route is for the user to track the time of the exercise.
                                      return const NoTransitionPage(child: ExerciseTimerScreen());
                                    },
                                  ),
                                  GoRoute(
                                    path: "/result",
                                    name: "training-exercise-result",
                                    pageBuilder: (context, state) {
                                      /// In this route the result of the exercise is displayed as well as a list of all remaining
                                      /// exercises, so that the user can choose the next one and get going.
                                      /// The purpose of the route is for the user to check the results of the exercise and select the next one.
                                      return const NoTransitionPage(child: ExerciseResultScreen());
                                    },
                                  ),
                                ]),
                          ],
                        ),
                      ])
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
