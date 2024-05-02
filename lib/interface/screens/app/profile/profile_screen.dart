import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return firebase_ui.ProfileScreen(
      providers: [],
      actions: [
        firebase_ui.SignedOutAction((context) {
          context.pushReplacementNamed('sign-in');
        }),
        firebase_ui.AccountDeletedAction((context, user) {
          context.pushNamed('sign-in');
        })
      ],
      children: const [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Profile Screen'),
            ],
          ),
        )
      ],
    );
  }
}
