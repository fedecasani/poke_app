import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'presentation/screens/pokemon_list_screen.dart';
import 'presentation/providers/theme_provider.dart';
import 'domain/entities/pokemon.dart';

/// Entry point of the Pokémon application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PokemonAdapter());
  runApp(ProviderScope(child: MyApp()));
}

/// Main application widget that sets up the app's theme and home screen.
// ignore: use_key_in_widget_constructors
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieves the current theme from the ThemeProvider.
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokémon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light, // Establece el brillo según el tema
      ),
      home: PokemonListScreen(),
    );
  }
}
