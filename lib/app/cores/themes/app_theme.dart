import 'package:annotation/app/repos/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../index.dart';

class AppTheme {
  AppTheme._();
  static final instance = AppTheme._();
}

extension AppThemeDark on AppTheme {
  ThemeData darkTheme() {
    return ThemeData(
      dividerColor: AppColors.white,
      brightness: Brightness.dark,
      appBarTheme: _appBarTheme(isDark: true),
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.primary,
      primarySwatch: AppColors.primary.toMaterial(),
      elevatedButtonTheme: _elevatedButtonThemeData(),
      textTheme: _textTheme(isDark: true),
      fontFamily: _fontFamily(),
    );
  }
}

extension AppThemeData on AppTheme {
  AppBarTheme _appBarTheme({required bool isDark}) {
    return AppBarTheme(
      iconTheme: IconThemeData(color: dynamicTextColor(isDark)),
      titleTextStyle: TextStyle(
        color: dynamicTextColor(isDark),
        fontWeight: FontWeight.w700,
        fontSize: 18,
        fontFamily: _fontFamily(),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.resolveWith(
          (states) => const Size.fromHeight(44),
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (states) => const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  String? _fontFamily() {
    return 'notosan';
  }

  TextTheme _textTheme({required bool isDark}) {
    final textColor = dynamicTextColor(isDark);
    return TextTheme(
      displayLarge: TextStyle(color: textColor),
      displayMedium: TextStyle(color: textColor),
      displaySmall: TextStyle(color: textColor),
      headlineMedium: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(color: textColor),
      titleLarge: TextStyle(color: textColor),
      bodyLarge: TextStyle(color: textColor),
      bodyMedium: TextStyle(color: textColor),
      labelLarge: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

extension AppThemeLight on AppTheme {
  ThemeData lightTheme() {
    return ThemeData(
      dividerColor: AppColors.greyF5F5F5,
      brightness: Brightness.light,
      appBarTheme: _appBarTheme(isDark: false),
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.primary.toMaterial(),
      primarySwatch: AppColors.primary.toMaterial(),
      elevatedButtonTheme: _elevatedButtonThemeData(),
      textTheme: _textTheme(isDark: false),
      fontFamily: _fontFamily(),
    );
  }
}

extension AppThemeUtils on AppTheme {
  Color dynamicTextColor(bool isDark) {
    return isDark ? AppColors.white : AppColors.black;
  }

  switchLanguage({required bool isDark}) {
    final locale =
        Get.locale?.languageCode == AppTranslations.enLocale.languageCode
            ? AppTranslations.khLocale
            : AppTranslations.enLocale;
    Get.updateLocale(locale);
    // MARK: - Also need to update the theme in order to switch the font family
    Get.changeTheme(isDark ? darkTheme() : lightTheme());
  }

  switchTheme({required bool isDark}) {
    Get.changeTheme(isDark ? lightTheme() : darkTheme());
  }
}
