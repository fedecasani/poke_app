import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Creates a [StateNotifierProvider] to manage the application's theme.
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

/// Class that extends [StateNotifier] to manage the theme state.
class ThemeNotifier extends StateNotifier<ThemeMode> {
  /// Creates an instance of [ThemeNotifier] with the default dark mode.
  ThemeNotifier() : super(ThemeMode.dark); // Cambiar a ThemeMode.dark para iniciar en modo oscuro

  /// Toggles between light and dark mode.
  ///
  /// Changes the theme state to [ThemeMode.dark] if the current state is 
  /// [ThemeMode.light], or to [ThemeMode.light] if the current state is 
  /// [ThemeMode.dark].
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
