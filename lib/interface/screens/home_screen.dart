import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    onLoginTap() {
      context.pushNamed("sign-in");
    }

    return Scaffold(
      backgroundColor: const Color(0xff1b1b1f),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_background.jpg'),
            opacity: .3,
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 165.0,
                  width: 165.0,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: () => context.goNamed("sign-in"), child: const Text("Get started")),
                    const Column(children: []),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlutterLogo(size: 40.0),
                        SizedBox(width: 10.0),
                        Text(
                          'Powered by Flutter',
                          style: TextStyle(color: Color(0xffe4e2e6)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
