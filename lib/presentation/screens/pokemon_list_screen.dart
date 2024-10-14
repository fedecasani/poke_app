import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app/domain/entities/pokemon.dart';
import '../providers/pokemon_provider.dart';
import '../providers/theme_provider.dart';
import 'pokemon_detail_screen.dart';

/// A screen that displays a list of Pokémon.
/// 
/// It shows a carousel of Pokémon at the top and a list of Pokémon below it. 
/// It uses a paginated approach to load more Pokémon as the user scrolls to the bottom of the list.
class PokemonListScreen extends ConsumerStatefulWidget {
  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

/// State for the [PokemonListScreen] that manages loading Pokémon data, 
/// controlling pagination, and interacting with the Pokémon detail screen.
class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Pokemon> _pokemons = [];
  List<Pokemon> _filteredPokemons = [];
  int _offset = 0;
  bool _isLoading = false;
  String _searchQuery = '';

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

  /// Loads Pokémon data and updates the internal state.
  Future<void> _loadPokemons() async {
    setState(() {
      _isLoading = true;
    });

    final pokemonList = await ref.read(pokemonListProvider(_offset).future);

    setState(() {
      _pokemons.addAll(pokemonList);
      _filteredPokemons = _pokemons;
      _offset += pokemonList.length;
      _isLoading = false;
    });
  }

  /// Filters the Pokémon based on the search query.
  ///
  /// This method updates the [_filteredPokemons] list with Pokémon that match the given [query].
  /// 
  /// The search is case insensitive.
  void _filterPokemons(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredPokemons = _pokemons.where((pokemon) {
        return pokemon.name.toLowerCase().contains(_searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon List', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          /// Carousel that displays Pokémon cards.
          SizedBox(
            height: 220,
            child: _pokemons.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : PageView.builder(
                    itemCount: _pokemons.length,
                    controller: PageController(viewportFraction: 0.5, initialPage: 1),
                    itemBuilder: (context, index) {
                      final pokemon = _pokemons[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          width: 250,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PokemonDetailScreen(pokemon: pokemon)),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    pokemon.imageUrl,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    pokemon.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 16),

          /// Search bar for filtering Pokémon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                labelText: 'Search Pokemon',
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search, color: isDarkMode ? Colors.white : Colors.black),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              onChanged: _filterPokemons,
            ),
          ),
          const SizedBox(height: 16),

          /// List that displays Pokémon names and images.
          Expanded(
            child: _filteredPokemons.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: _filteredPokemons.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _filteredPokemons.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final pokemon = _filteredPokemons[index];
                      return ListTile(
                        leading: Image.network(pokemon.imageUrl, width: 50, height: 50),
                        title: Text(
                          pokemon.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
          ),
        ],
      ),

      /// Drawer that contains a toggle for switching between dark and light mode.
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 125,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Settings', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ),
            ListTile(
              leading: Icon(isDarkMode ? Icons.bedtime : Icons.wb_sunny),
              title: Text(isDarkMode ? 'Dark Mode' : 'Light Mode'),
              onTap: () {
                ref.read(themeProvider.notifier).toggleTheme();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
