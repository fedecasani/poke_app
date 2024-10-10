import 'package:flutter/material.dart';
import '../../domain/entities/pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetailScreen({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(pokemon.imageUrl), // Muestra la imagen del Pokémon
            SizedBox(height: 16), // Espacio entre la imagen y el texto
            Text(pokemon.name, style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
