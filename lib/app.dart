import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/app_state.dart';
import 'core/theme.dart';
import 'router.dart';
import 'widgets/app_chrome.dart';
import 'widgets/opening_splash.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    final localeController = context.watch<LocaleController>();

    return MaterialApp.router(
      title: 'Mazen Matran — Portfolio',
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: themeController.isDark ? ThemeMode.dark : ThemeMode.light,
      locale: localeController.locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => SelectionArea(
        child: OpeningSplash(
          child: AppChrome(child: child ?? const SizedBox.shrink()),
        ),
      ),
    );
  }
}
