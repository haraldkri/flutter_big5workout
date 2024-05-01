import 'package:flutter/material.dart';
import 'package:flutter_big5workout/interface/screens/router.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  App({super.key});

  final colorThemeLight = ColorScheme.fromSeed(seedColor: const Color(0xFF3870FF));
  final colorThemeDark = ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: const Color(0xFF3870FF));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorThemeLight,
        textTheme: GoogleFonts.robotoTextTheme(ThemeData(colorScheme: colorThemeLight).textTheme),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: colorThemeDark,
        textTheme: GoogleFonts.robotoTextTheme(
          ThemeData(colorScheme: colorThemeDark).textTheme,
        ),
      ),
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}
