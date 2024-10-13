import 'package:flutter/material.dart';
import '../../domain/entities/pokemon.dart';
import 'package:poke_app/presentation/widgets/custom_app_bar.dart';

/// Screen that displays the details of a Pokémon.
///
/// This class is a stateless widget that presents detailed information
/// about a Pokémon, including its name and image.
class PokemonDetailScreen extends StatelessWidget {
  /// Instance of the Pokémon to be displayed on the screen.
  final Pokemon pokemon;

  /// Constructor for [PokemonDetailScreen].
  ///
  /// Requires a [Pokemon] object that contains the information of the
  /// Pokémon to be displayed.
  PokemonDetailScreen({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: pokemon.name.capitalizeFirstLetter()), // Usar el CustomAppBar aquí
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Image.network(
              pokemon.imageUrl,
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
            Text(
              pokemon.name.capitalizeFirstLetter(),
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

/// Extension for the [String] class that provides additional methods.
///
/// This extension includes methods that facilitate string manipulation.
extension StringExtension on String {
  /// Capitalizes the first letter of the string.
  ///
  /// Returns a new string with the first letter in uppercase.
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return '';
    }
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}
