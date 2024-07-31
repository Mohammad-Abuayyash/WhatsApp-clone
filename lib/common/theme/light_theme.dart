import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    scaffoldBackgroundColor: COLORS.backgroundLight,
  );
}
