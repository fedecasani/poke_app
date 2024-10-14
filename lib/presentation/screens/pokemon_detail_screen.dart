import 'package:flutter/material.dart';
import 'package:poke_app/domain/repositories/pokemon_details_repository.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_details.dart';
import '../../domain/usecases/get_pokemon_details.dart'; // Asegúrate de importar tu caso de uso
import 'package:poke_app/presentation/widgets/custom_app_bar.dart';

/// Screen that displays the details of a Pokémon.
///
class PokemonDetailScreen extends StatefulWidget {
  /// Instance of the Pokémon to be displayed on the screen.
  final Pokemon pokemon;

  /// Constructor for [PokemonDetailScreen].
  PokemonDetailScreen({required this.pokemon});

  @override
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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar detalles del Pokémon'));
          } else if (snapshot.hasData) {
            final pokemonDetails = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Image.network(
                    widget.pokemon.imageUrl,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),

                      // Mostrar Altura y Peso en una fila
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Altura: ${pokemonDetails.height} dm',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Peso: ${pokemonDetails.weight} hg',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      // Mostrar Tipos
                      Text(
                        'Tipos: ${pokemonDetails.types.map((type) => type.name.capitalizeFirstLetter()).join(', ')}',
                        style: TextStyle(fontSize: 16),
                      ),

                      SizedBox(height: 8),

                      // Mostrar Habilidades
                      Text(
                        'Habilidades: ${pokemonDetails.abilities.map((ability) => ability.name.capitalizeFirstLetter()).join(', ')}',
                        style: TextStyle(fontSize: 16),
                      ),

                      SizedBox(height: 16),

                      // Título para Estadísticas
                      Text(
                        'Estadísticas:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 8),

                      // Tabla para las estadísticas
                      Table(
                        border: TableBorder.all(
                            color: Colors.grey), // Líneas de la tabla
                        columnWidths: {
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
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${stat.baseStat}',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(
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
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}
