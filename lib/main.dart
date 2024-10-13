import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/screens/pokemon_list_screen.dart';
import 'presentation/providers/theme_provider.dart';

/// Entry point of the Pokémon application.
void main() {
  runApp(ProviderScope(child: MyApp()));
}

/// Main application widget that sets up the app's theme and home screen.
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtiene el tema actual desde el ThemeProvider
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokémon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light,
      ),
      home: PokemonListScreen(), // Pantalla principal de la aplicación
    );
  }
}
