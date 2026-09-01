import 'package:flutter/material.dart';

/// Site always boots dark; the toggle only affects the current session.
class ThemeController extends ChangeNotifier {
  bool _isDark = true;
  bool get isDark => _isDark;

  void toggle() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

/// Site always boots in English; Arabic flips the whole app to RTL via
/// Flutter's own Localizations/Directionality machinery.
class LocaleController extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void toggle() => setLocale(_locale.languageCode == 'en' ? const Locale('ar') : const Locale('en'));
}

/// Hidden by default; opened via the hamburger button.
class SidebarController extends ChangeNotifier {
  bool _isOpen = false;
  bool get isOpen => _isOpen;

  void open() {
    if (_isOpen) return;
    _isOpen = true;
    notifyListeners();
  }

  void close() {
    if (!_isOpen) return;
    _isOpen = false;
    notifyListeners();
  }

  void toggle() {
    _isOpen = !_isOpen;
    notifyListeners();
  }
}

/// Tracks which page is active so app-root-level widgets (the cosmic
/// background, the sidebar) can react to navigation without living inside
/// the per-page widget tree themselves — if they did, go_router would
/// destroy and recreate their State on every navigation, losing whatever
/// animation was mid-flight.
class CurrentPageController extends ChangeNotifier {
  String _page = 'home';
  String get page => _page;

  void setPage(String page) {
    if (_page == page) return;
    _page = page;
    notifyListeners();
  }
}
