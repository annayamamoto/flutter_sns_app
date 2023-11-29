import 'package:flutter/material.dart';

ThemeData lightThemeData({required BuildContext context}) {
  return ThemeData.light().copyWith(
      primaryColor: Colors.deepPurpleAccent,
      scaffoldBackgroundColor: Colors.white);
}

ThemeData darkThemeData({required BuildContext context}) {
  return ThemeData.light().copyWith(
      primaryColor: Colors.orange.shade200,
      scaffoldBackgroundColor: Colors.black);
}
