import 'package:flutter/material.dart';
import 'package:flutter_big5workout/interface/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'interface/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3870FF)),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: const Color(0xFF3870FF)),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      themeMode: ThemeMode.dark,
      routes: {
        "login": (context) => const LoginScreen(),
        "home": (context) => HomeScreen(),
      },
      initialRoute: "login",
    );
  }
}
