import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_aj/provider/data_provider.dart';
import 'package:provider/provider.dart';
import './views/introductory_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
    return ChangeNotifierProvider(
      create: (context) => FirebaseDataProvider(),
      child: MaterialApp(
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
      ),
    );
  }
}
