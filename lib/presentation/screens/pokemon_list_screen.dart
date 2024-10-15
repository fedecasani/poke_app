import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:poke_app/domain/entities/pokemon.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../providers/pokemon_provider.dart';
import '../providers/theme_provider.dart';
import 'pokemon_detail_screen.dart';

/// Screen that displays a list of Pokémon with search and connectivity handling.
class PokemonListScreen extends ConsumerStatefulWidget {
  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Pokemon> _pokemons = [];
  List<Pokemon> _filteredPokemons = [];
  int _offset = 0;
  bool _isLoading = false;
  String _searchQuery = '';
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _loadPokemons();

    _scrollController.addListener(() {
      // Load more Pokémon when reaching the bottom of the list
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
        _loadPokemons();
      }
    });
  }

  /// Checks the network connectivity status.
  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  /// Loads Pokémon from the API or local storage.
  Future<void> _loadPokemons() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch Pokémon from the provider
      final pokemonList = await ref.read(pokemonListProvider(_offset).future);
      
      // Open the Hive box and store fetched Pokémon
      final box = await Hive.openBox<Pokemon>('pokemonBox');
      for (var pokemon in pokemonList) {
        await box.put(pokemon.name, pokemon);
      }

      setState(() {
        _pokemons.addAll(pokemonList);
        _filteredPokemons = _pokemons;
        _offset += pokemonList.length;
        _isLoading = false;
      });
    } catch (e) {
      // Load stored Pokémon from Hive if fetching fails
      final box = await Hive.openBox<Pokemon>('pokemonBox');
      final storedPokemons = box.values.toList();

      setState(() {
        _pokemons.addAll(storedPokemons);
        _filteredPokemons = _pokemons;
        _isLoading = false;
      });
    }
  }

  /// Filters Pokémon based on the search query.
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
                                  _isConnected
                                      ? Image.network(
                                          pokemon.imageUrl,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                                        )
                                      : Image.asset(  // Cambiar a una imagen local o placeholder
                                          'assets/images/placeholder.png', // Asegúrate de tener esta imagen
                                          width: 120,
                                          height: 120,
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
                        leading: _isConnected
                            ? Image.network(pokemon.imageUrl, width: 50, height: 50, errorBuilder: (context, error, stackTrace) => const Icon(Icons.error))
                            : Image.asset( // Cambiar a una imagen local o placeholder
                                'assets/images/placeholder.png', // Asegúrate de tener esta imagen
                                width: 50,
                                height: 50,
                              ),
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
    Hive.close();
    _scrollController.dispose();
    super.dispose();
  }
}
