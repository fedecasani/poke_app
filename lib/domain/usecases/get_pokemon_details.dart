import '../entities/pokemon_details.dart';
import '../repositories/pokemon_details_repository.dart';

/// Class that represents the use case for obtaining Pokémon details.
///
/// This class encapsulates the logic necessary to access specific Pokémon
/// details through a repository.
class GetPokemonDetails {
  final PokemonDetailsRepository repository;

  /// Constructor for [GetPokemonDetails].
  ///
  /// Requires an instance of [PokemonDetailsRepository] to perform data
  /// requests.
  GetPokemonDetails(this.repository);

  /// Calls the repository method to retrieve the details of a Pokémon.
  ///
  /// The [url] parameter is the URL to fetch the details from.
  ///
  /// Returns a [Future] that completes with a [PokemonDetails] object
  /// containing the requested information.
  Future<PokemonDetails> call(String url) async {
    return await repository.fetchPokemonDetails(url);
  }
}
