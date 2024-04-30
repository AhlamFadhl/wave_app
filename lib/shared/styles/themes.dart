import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wave_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  iconTheme: const IconThemeData(color: primaryColor),
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: secondColor),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey.shade300,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: primaryColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: primaryColor,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'Almarai',
);
