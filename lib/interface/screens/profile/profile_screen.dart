import 'package:flutter/material.dart';

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
              Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
