import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app/domain/entities/pokemon.dart';
import '../providers/pokemon_provider.dart';
import 'pokemon_detail_screen.dart';
import 'package:poke_app/presentation/widgets/custom_app_bar.dart';

/// Screen that displays a list of Pokémon.
class PokemonListScreen extends ConsumerStatefulWidget {
  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Pokemon> _pokemons = [];
  int _offset = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPokemons();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
        _loadPokemons();
      }
    });
  }

  Future<void> _loadPokemons() async {
    setState(() {
      _isLoading = true;
    });
    
    final pokemonList = await ref.read(pokemonListProvider(_offset).future);
    
    setState(() {
      _pokemons.addAll(pokemonList);
      _offset += pokemonList.length;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Pokémon List'),
      body: _pokemons.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _pokemons.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _pokemons.length) {
                  return Center(child: CircularProgressIndicator());
                }

                final pokemon = _pokemons[index];
                return ListTile(
                  leading: Image.network(pokemon.imageUrl, width: 50, height: 50),
                  title: Text(
                    pokemon.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PokemonDetailScreen(pokemon: pokemon)),
                    );
                  },
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
