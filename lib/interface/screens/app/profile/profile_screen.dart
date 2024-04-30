import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Profile Screen'),
          ElevatedButton(
            onPressed: () {
              // Navigate to the login screen
              context.pushReplacementNamed( 'sign-in');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
