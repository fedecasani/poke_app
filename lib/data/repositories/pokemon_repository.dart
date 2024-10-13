import 'package:poke_app/domain/repositories/pokemon_repository.dart';
import '../../domain/entities/pokemon.dart';
import '../datasources/pokemon_remote_datasource.dart';

/// Implementation of [PokemonRepository] for obtaining Pokémon data.
/// 
/// This class uses a remote data source to retrieve a list of 
/// Pokémon through the API.
class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDatasource remoteDatasource;

  /// Constructor for [PokemonRepositoryImpl].
  /// 
  /// Requires an instance of [PokemonRemoteDatasource] to perform data
  /// requests.
  PokemonRepositoryImpl({required this.remoteDatasource});

  /// Retrieves a list of Pokémon from the remote data source.
  /// 
  /// The [offset] parameter indicates the position from which to start 
  /// retrieving Pokémon. Returns a list of [Pokemon].
  @override
  Future<List<Pokemon>> getPokemonList(int offset) async {
    // Calls the remote data source to obtain the list of Pokémon.
    final pokemonModels = await remoteDatasource.fetchPokemonList(offset);
    return pokemonModels; // Returns the retrieved list of Pokémon.
  }
}
