import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pokemon_provider.dart';
import 'pokemon_detail_screen.dart';

class PokemonListScreen extends ConsumerStatefulWidget {
  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  final ScrollController _scrollController = ScrollController();
  int _offset = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          _offset += 20; // Incrementa el offset para obtener más Pokémon
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonList = ref.watch(pokemonListProvider(_offset));

    return Scaffold(
      appBar: AppBar(title: Text('Pokémon List')),
      body: pokemonList.when(
        data: (pokemons) => ListView.builder(
          controller: _scrollController,
          itemCount: pokemons.length,
          itemBuilder: (context, index) {
            final pokemon = pokemons[index];
            return ListTile(
              leading: Image.network(pokemon.imageUrl, width: 50, height: 50), // Muestra la imagen
              title: Text(pokemon.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PokemonDetailScreen(pokemon: pokemon)),
                );
              },
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
