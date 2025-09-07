import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A6CF7)),
      textTheme: GoogleFonts.interTextTheme(),
      scaffoldBackgroundColor: const Color(0xFFF7F8FA),
    );

    return MaterialApp.router(
      title: 'Portfolio',
      theme: theme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
