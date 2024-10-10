import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app/data/datasources/pokemon_remote_datasource.dart';
import 'package:poke_app/data/repositories/pokemon_repository.dart';
import 'package:poke_app/domain/repositories/pokemon_repository.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemon_list.dart';

// Provider para manejar el caso de uso
final pokemonListProvider = FutureProvider.family<List<Pokemon>, int>((ref, offset) async {
  final getPokemonList = ref.read(getPokemonListProvider);
  return getPokemonList(offset);
});

// Proveedor del caso de uso GetPokemonList
final getPokemonListProvider = Provider<GetPokemonList>((ref) {
  // Aquí creamos una instancia de GetPokemonList con el repositorio
  final repository = ref.read(pokemonRepositoryProvider);
  return GetPokemonList(repository);
});

// Proveedor del repositorio de Pokemon
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  final datasource = ref.read(pokemonRemoteDatasourceProvider);
  return PokemonRepositoryImpl(remoteDatasource: datasource);
});

// Proveedor del datasource de Pokemon
final pokemonRemoteDatasourceProvider = Provider<PokemonRemoteDatasource>((ref) {
  final dio = Dio();
  return PokemonRemoteDatasourceImpl(dio: dio);
});
