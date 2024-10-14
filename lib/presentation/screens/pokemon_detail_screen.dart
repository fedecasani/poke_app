import 'package:flutter/material.dart';
import 'package:poke_app/domain/repositories/pokemon_details_repository.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_details.dart';
import '../../domain/usecases/get_pokemon_details.dart';
import 'package:poke_app/presentation/widgets/custom_app_bar.dart';

/// A screen that displays the details of a Pokémon.
///
/// This screen shows various information about a Pokémon including its
/// image, height, weight, stats, types, and abilities.
class PokemonDetailScreen extends StatefulWidget {
  /// The Pokémon instance to be displayed on the screen.
  final Pokemon pokemon;

  /// Creates an instance of [PokemonDetailScreen].
  ///
  /// Requires a [Pokemon] object to display its details.
  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  // ignore: library_private_types_in_public_api
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

/// The state class for [PokemonDetailScreen].
class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  /// A [Future] that holds the details of the Pokémon.
  late Future<PokemonDetails> _pokemonDetails;

  @override
  void initState() {
    super.initState();
    // Initializes the future to fetch Pokémon details
    final getPokemonDetails = GetPokemonDetails(PokemonDetailsRepository());
    _pokemonDetails = getPokemonDetails.call(widget.pokemon.url);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(title: widget.pokemon.name.capitalizeFirstLetter()),
      body: FutureBuilder<PokemonDetails>(
        future: _pokemonDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error al cargar detalles del Pokémon'));
          } else if (snapshot.hasData) {
            final pokemonDetails = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Image.network(
                    widget.pokemon.imageUrl,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0), // Espaciado alrededor de la columna
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        // Display Height and Weight in a row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Height: ',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '${pokemonDetails.height} dm',
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Weight: ',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '${pokemonDetails.weight} hg',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Table for stats
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espaciado horizontal
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.black
                                  : Colors.lightBlue[50], // Background color of the table
                              border: Border.all(
                                  color: isDarkMode
                                      ? Colors.black
                                      : Colors.black), // Border of the table
                              borderRadius: BorderRadius.circular(8), // Rounded corners
                            ),
                            child: Table(
                              border: TableBorder.all(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black), // Borders of the table
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                              },
                              children: pokemonDetails.stats.map((stat) {
                                return TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        stat.name.capitalizeFirstLetter(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${stat.baseStat}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Display Types
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Type(s): ',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: pokemonDetails.types
                                    .map((type) =>
                                        type.name.capitalizeFirstLetter())
                                    .join(', '),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Display Abilities
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Abilities: ',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: pokemonDetails.abilities
                                    .map((ability) =>
                                        ability.name.capitalizeFirstLetter())
                                    .join(', '),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(
                child: Text('No se encontraron detalles del Pokémon'));
          }
        },
      ),
    );
  }
}

/// Extension for the [String] class that provides additional methods.
///
/// This extension includes methods to manipulate and format strings.
extension StringExtension on String {
  /// Capitalizes the first letter of the string.
  ///
  /// Returns a new string with the first letter in uppercase.
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return '';
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
