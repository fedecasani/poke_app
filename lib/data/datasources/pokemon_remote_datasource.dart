import 'package:dio/dio.dart';
import 'package:poke_app/data/models/pokemon_model.dart';

abstract class PokemonRemoteDatasource {
  Future<List<PokemonModel>> fetchPokemonList(int offset);
}

class PokemonRemoteDatasourceImpl implements PokemonRemoteDatasource {
  final Dio dio;

  PokemonRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<PokemonModel>> fetchPokemonList(int offset) async {
    final response = await dio.get('https://pokeapi.co/api/v2/pokemon?limit=20&offset=$offset');
    if (response.statusCode == 200) {
      List results = response.data['results'];
      return results.map((pokemon) => PokemonModel.fromJson(pokemon)).toList();
    } else {
      throw Exception('Error fetching Pokemon');
    }
  }
}
