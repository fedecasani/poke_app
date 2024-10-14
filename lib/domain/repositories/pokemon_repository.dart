import '../entities/pokemon.dart';

/// Interface that defines the contract for the Pokémon repository.
///
/// This abstract class establishes the methods that must be implemented
/// to access Pokémon data from various sources, allowing for flexibility
/// in how Pokémon data is retrieved.
abstract class PokemonRepository {
  /// Retrieves a list of [Pokemon] from a specific offset.
  ///
  /// The [offset] parameter indicates the position from which to start
  /// retrieving the list of Pokémon. This allows for pagination or 
  /// loading Pokémon in chunks.
  ///
  /// Returns a [Future] that completes with a list of [Pokemon].
  Future<List<Pokemon>> getPokemonList(int offset);
}
