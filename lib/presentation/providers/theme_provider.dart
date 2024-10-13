import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Crea un StateNotifierProvider para manejar el tema de la aplicación.
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

/// Clase que extiende [StateNotifier] para gestionar el estado del tema.
class ThemeNotifier extends StateNotifier<ThemeMode> {
  /// Crea una instancia de [ThemeNotifier] con el modo claro por defecto.
  ThemeNotifier() : super(ThemeMode.light);

  /// Alterna entre el modo claro y oscuro.
  ///
  /// Cambia el estado del tema a [ThemeMode.dark] si el estado actual es 
  /// [ThemeMode.light], o a [ThemeMode.light] si el estado actual es 
  /// [ThemeMode.dark].
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
