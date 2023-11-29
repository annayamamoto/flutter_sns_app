import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = ChangeNotifierProvider((ref) => ThemesModel());

class ThemesModel extends ChangeNotifier {
  bool isDarkTheme = true;

  Future<void> setIsDarkTheme({required bool value}) async {
    isDarkTheme = value;
    notifyListeners();
  }
}
