import '../entities/pokemon.dart';

/// Interface that defines the contract for the Pokémon repository.
///
/// This abstract class establishes the methods that must be implemented
/// to access Pokémon data from various sources.
abstract class PokemonRepository {
  /// Retrieves a list of [Pokemon] from a specific offset.
  ///
  /// The [offset] parameter is used to indicate the position from which
  /// to start retrieving the list of Pokémon.
  Future<List<Pokemon>> getPokemonList(int offset);
}
