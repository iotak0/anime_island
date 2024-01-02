import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// Main app theme, called [CustomTheme], is defined here.
class CustomTheme {
  static const svgTheme = SvgTheme(currentColor: PColors.premiumColor);
/*
GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.displayLarge,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  ),
   */
  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.cairo(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.cairo(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodySmall: GoogleFonts.cairo(
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    titleMedium: GoogleFonts.cairo(
      fontSize: 15.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    titleSmall: GoogleFonts.cairo(
      fontSize: 17.0,
      color: Colors.white,
    ),
    displayLarge: GoogleFonts.cairo(
      fontSize: 31.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: GoogleFonts.cairo(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displaySmall: GoogleFonts.cairo(
      fontSize: 19.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      decoration: TextDecoration.none,
    ),
    headlineMedium: GoogleFonts.cairo(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      decoration: TextDecoration.none,
    ),
    headlineSmall: GoogleFonts.cairo(
      fontSize: 19.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      decoration: TextDecoration.none,
    ),
    titleLarge: GoogleFonts.cairo(
      fontSize: 19.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: PColors.tkDarkBlue,
      scaffoldBackgroundColor: PColors.tkDarkerBlue,
      colorScheme: ColorScheme.dark(
        primary: Colors.white,
        onPrimary: Colors.white,
        secondary: Colors.white38,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        onBackground: Colors.white,
        surface: Colors.grey,
        onSurface: Colors.white,
      ),
      hintColor: PColors.tkGradientBlue,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: PColors.tkDarkBlue,
        centerTitle: true,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        backgroundColor: PColors.tkDarkBlue,
      ),
    );
  }
}
