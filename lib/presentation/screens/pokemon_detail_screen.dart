import 'package:flutter/material.dart';
import '../../domain/entities/pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetailScreen({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pokemon.name.capitalizeFirstLetter(), // Asegúrate de tener una extensión para capitalizar
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            // Imagen del Pokémon más grande
            Image.network(
              pokemon.imageUrl,
              width: 250,  // Aumenta el ancho de la imagen
              height: 250, // Aumenta la altura de la imagen
              fit: BoxFit.cover,
            ),
            Text(
              pokemon.name.capitalizeFirstLetter(),
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            // Aquí podrías agregar más detalles del Pokémon si lo deseas
          ],
        ),
      ),
    );
  }
}

// Extensión para capitalizar la primera letra de la cadena
extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return '';
    }
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}
