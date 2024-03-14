import 'package:flutter/material.dart';

import '../widgets/circular_icon_button.dart';
import '../widgets/text_divider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    onLoginTap() {
      Navigator.pushNamed(context, "home");
    }

    return Scaffold(
      backgroundColor: const Color(0xff1b1b1f),
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
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
                    Column(
                      children: [
                        const TextDivider(
                          text: 'sign in',
                          indent: 60,
                          color: Color(0xffe4e2e6),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularIconButton(
                              semanticLabel: 'Twitter Login Button',
                              imagePath: 'assets/icons/twitter_icon.svg',
                              onTap: () {
                                onLoginTap();
                              },
                            ),
                            const SizedBox(width: 15.0),
                            CircularIconButton(
                              semanticLabel: 'Facebook Login Button',
                              imagePath: 'assets/icons/facebook_icon.svg',
                              onTap: () {
                                onLoginTap();
                              },
                            ),
                            const SizedBox(width: 15.0),
                            CircularIconButton(
                              semanticLabel: 'Google Login Button',
                              imagePath: 'assets/icons/google_icon.svg',
                              onTap: () {
                                onLoginTap();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
