import 'package:customer/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.red,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.darkModePrimary,
          onPrimary: AppColors.darkModePrimary,
          secondary: AppColors.background,
          onSecondary: AppColors.background,
          error: AppColors.background,
          onError: AppColors.background,
          background: AppColors.background,
          onBackground: AppColors.background,
          surface: AppColors.background,
          onSurface: AppColors.background),
      primaryColor: AppColors.darkModePrimary,
      hintColor: Colors.black38,
      brightness: Brightness.light,
      buttonTheme: ButtonThemeData(
        textTheme:
            ButtonTextTheme.primary, //  <-- dark text for light background
        colorScheme:
            Theme.of(context).colorScheme.copyWith(primary: AppColors.primary),
      ),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle:
              GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
    );
  }
}
