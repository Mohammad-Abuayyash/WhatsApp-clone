import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    scaffoldBackgroundColor: COLORS.backgroundLight,
    colorScheme: const ColorScheme.light(
      surface: COLORS.backgroundLight,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: COLORS.greenLight,
        foregroundColor: COLORS.backgroundLight,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: COLORS.backgroundLight,
      modalBackgroundColor: COLORS.backgroundLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
  );
}
