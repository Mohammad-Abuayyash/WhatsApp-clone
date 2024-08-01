import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  return LocaleNotifier(const Locale('en'));
});

class LocaleNotifier extends StateNotifier<Locale?> {
  LocaleNotifier(Locale? state) : super(state);

  void setLocale(Locale locale) {
    state = locale;
  }
}
