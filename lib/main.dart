import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './views/introductory_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final color1 = const Color(0xFF31363F);
  final color2 = const Color(0xFF222831);
  final color3 = const Color(0xFFEEEEEE);
  final color4 = const Color(0xFF76ABAE);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project-AJ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: color1,
        appBarTheme: AppBarTheme(
          color: color2,
          toolbarHeight: 90,
          titleTextStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
            color: color3,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          surface: color1,
          onSurface: color3,
          onPrimary: color3,
          onSecondary: color3,
        ),
        textTheme: TextTheme(
          bodyLarge:
              GoogleFonts.lato(textStyle: const TextStyle(letterSpacing: 4)),
          bodyMedium:
              GoogleFonts.heebo(textStyle: const TextStyle(letterSpacing: 4)),
          bodySmall:
              GoogleFonts.lato(textStyle: const TextStyle(letterSpacing: 4)),
        ),
        useMaterial3: true,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF76ABAE),
        ),
      ),
      home: const IntroductoryView(),
    );
  }
}
