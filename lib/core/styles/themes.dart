import 'package:flutter/material.dart';
import 'package:se7etee/core/constants/app_fonts.dart';
import 'package:se7etee/core/styles/colors.dart';
import 'package:se7etee/core/styles/text_style.dart';

abstract class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    fontFamily: AppFonts.cairo,
    scaffoldBackgroundColor: AppColors.backgroundcolor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      centerTitle: true,
      foregroundColor: AppColors.whitecolor,
      titleTextStyle: TextStyle(
        fontFamily: AppFonts.cairo,
        color: AppColors.whitecolor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      surfaceTintColor: Colors.transparent,
    ),
    dividerTheme: DividerThemeData(color: AppColors.bordercolor),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(60, 30),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.textcolor,
      backgroundColor: Colors.transparent,
      selectedLabelStyle: TextStyles.caption212.copyWith(
        fontWeight: FontWeight.w600,
        height: 2,
      ),
      unselectedLabelStyle: TextStyles.caption212.copyWith(
        fontWeight: FontWeight.w600,
        height: 2,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.body16.copyWith(color: AppColors.textcolor),
      fillColor: AppColors.whitecolor,
      filled: true,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
