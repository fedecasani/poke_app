import 'package:dio/dio.dart';
import 'package:poke_app/data/models/pokemon_model.dart';

/// A remote data source for fetching a list of Pokémon from the API.
///
/// This abstract class defines the contract for obtaining the Pokémon list.
abstract class PokemonRemoteDatasource {
  /// Fetches a list of [PokemonModel] from a specific offset.
  ///
  /// The [offset] parameter indicates the position from which to retrieve
  /// the Pokémon. Returns a list of Pokémon models obtained from the API.
  Future<List<PokemonModel>> fetchPokemonList(int offset);
}

/// Implementation of [PokemonRemoteDatasource] using Dio to make HTTP requests.
///
/// This class is responsible for making a GET request to the Pokémon API and
/// returning a list of [PokemonModel] based on the received data.
class PokemonRemoteDatasourceImpl implements PokemonRemoteDatasource {
  final Dio dio;

  /// Constructor for [PokemonRemoteDatasourceImpl].
  ///
  /// Requires an instance of [Dio] to perform HTTP requests.
  PokemonRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<PokemonModel>> fetchPokemonList(int offset) async {
    // Makes a GET request to the Pokémon API with the specified offset.
    final response = await dio.get('https://pokeapi.co/api/v2/pokemon?limit=20&offset=$offset');
    
    // If the request was successful, process and return the list of Pokémon.
    if (response.statusCode == 200) {
      List results = response.data['results'];
      return results.map((pokemon) => PokemonModel.fromJson(pokemon)).toList();
    } else {
      // Throws an exception in case of error.
      throw Exception('Error fetching Pokemon');
    }
  }
}
