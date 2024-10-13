import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

/// Class that represents the use case for obtaining the Pokémon list.
///
/// This class encapsulates the logic necessary to access Pokémon data
/// through a repository.
class GetPokemonList {
  final PokemonRepository repository;

  /// Constructor for [GetPokemonList].
  ///
  /// Requires an instance of [PokemonRepository] to perform data
  /// requests.
  GetPokemonList(this.repository);

  /// Calls the repository method to retrieve the list of Pokémon.
  ///
  /// The [offset] parameter is used to indicate the position from which
  /// to start retrieving the Pokémon list.
  Future<List<Pokemon>> call(int offset) async {
    return await repository.getPokemonList(offset);
  }
}
