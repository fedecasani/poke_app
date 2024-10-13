import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pokemon_provider.dart';
import 'pokemon_detail_screen.dart'; 

/// Screen that displays a list of Pokémon.
///
/// This class is a stateful widget that presents a list of Pokémon
/// using the Riverpod state management pattern.
class PokemonListScreen extends ConsumerStatefulWidget {
  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  final ScrollController _scrollController = ScrollController();  /// Controller for the list's scroll.
  int _offset = 0;  /// Offset for paginating the Pokémon list.

  @override
  void initState() {
    super.initState();

    // Adds a listener to the scroll controller.
    _scrollController.addListener(() {
      // If the end of the list is reached, increase the offset.
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          _offset += 20; 
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watches the state of the Pokémon list.
    final pokemonList = ref.watch(pokemonListProvider(_offset));

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon List', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
      body: pokemonList.when(
        data: (pokemons) => ListView.builder(
          controller: _scrollController,
          itemCount: pokemons.length,
          itemBuilder: (context, index) {
            final pokemon = pokemons[index];
            return ListTile(
              leading: Image.network(pokemon.imageUrl, width: 50, height: 50),
              title: Text(
                pokemon.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                // Navigate to the detail screen of the selected Pokémon.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PokemonDetailScreen(pokemon: pokemon)),
                );
              },
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()), // Shows loading indicator while fetching data.
        error: (error, stack) => Center(child: Text('Error: $error')), // Displays an error message in case of failure.
      ),
    );
  }

  @override
  void dispose() {
    // Disposes the scroll controller when the screen is removed.
    _scrollController.dispose();
    super.dispose();
  }
}
