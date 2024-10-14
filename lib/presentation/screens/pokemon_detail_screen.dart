import 'package:flutter/material.dart';
import 'package:poke_app/domain/repositories/pokemon_details_repository.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_details.dart';
import '../../domain/usecases/get_pokemon_details.dart';
import 'package:poke_app/presentation/widgets/custom_app_bar.dart';

/// Screen that displays the details of a Pokémon.
///
class PokemonDetailScreen extends StatefulWidget {
  /// Instance of the Pokémon to be displayed on the screen.
  final Pokemon pokemon;

  /// Constructor for [PokemonDetailScreen].
  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  // ignore: library_private_types_in_public_api
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  late Future<PokemonDetails> _pokemonDetails;

  @override
  void initState() {
    super.initState();
    // Inicializa el futuro para obtener los detalles del Pokémon
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
                    padding: const EdgeInsets.all(
                        16.0), // Espaciado alrededor de la columna
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        // Mostrar Altura y Peso en una fila
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

                        // Tabla para las estadísticas
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0), // Espaciado horizontal
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.black
                                  : Colors.lightBlue[
                                      50], // Color de fondo de la tabla
                              border: Border.all(
                                  color: isDarkMode
                                      ? Colors.black
                                      : Colors.black), // Borde de la tabla
                              borderRadius: BorderRadius.circular(
                                  8), // Esquinas redondeadas
                            ),
                            child: Table(
                              border: TableBorder.all(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black), // Bordes de la tabla
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
                        ), // Mostrar Tipos

                        const SizedBox(height: 16),
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

                        // Mostrar Habilidades
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