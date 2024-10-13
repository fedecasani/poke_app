import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app/data/datasources/pokemon_remote_datasource.dart';
import 'package:poke_app/data/repositories/pokemon_repository.dart';
import 'package:poke_app/domain/repositories/pokemon_repository.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemon_list.dart';

final pokemonListProvider = FutureProvider.family<List<Pokemon>, int>((ref, offset) async {
  final getPokemonList = ref.read(getPokemonListProvider);
  return getPokemonList(offset);
});

final getPokemonListProvider = Provider<GetPokemonList>((ref) {
  final repository = ref.read(pokemonRepositoryProvider);
  return GetPokemonList(repository);
});

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  final datasource = ref.read(pokemonRemoteDatasourceProvider);
  return PokemonRepositoryImpl(remoteDatasource: datasource);
});

final pokemonRemoteDatasourceProvider = Provider<PokemonRemoteDatasource>((ref) {
  final dio = Dio();
  return PokemonRemoteDatasourceImpl(dio: dio);
});
