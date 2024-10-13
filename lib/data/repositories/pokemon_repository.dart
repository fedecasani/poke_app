import 'package:poke_app/domain/repositories/pokemon_repository.dart';

import '../../domain/entities/pokemon.dart';
import '../datasources/pokemon_remote_datasource.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDatasource remoteDatasource;

  PokemonRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Pokemon>> getPokemonList(int offset) async {
    final pokemonModels = await remoteDatasource.fetchPokemonList(offset);
    return pokemonModels;
  }
}
