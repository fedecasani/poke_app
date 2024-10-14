import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app/data/datasources/pokemon_remote_datasource.dart';
import 'package:poke_app/data/repositories/pokemon_repository.dart';
import 'package:poke_app/domain/repositories/pokemon_repository.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemon_list.dart';

/// A state provider that retrieves a list of Pokémon from a specific offset.
/// 
/// This provider uses [GetPokemonList] to access Pokémon data and manage
/// loading state.
final pokemonListProvider = FutureProvider.family<List<Pokemon>, int>((ref, offset) async {
  final getPokemonList = ref.read(getPokemonListProvider);
  return getPokemonList(offset);
});

/// Provider for [GetPokemonList].
/// 
/// This provider creates an instance of [GetPokemonList], which is used
/// to obtain the list of Pokémon from the repository.
final getPokemonListProvider = Provider<GetPokemonList>((ref) {
  final repository = ref.read(pokemonRepositoryProvider);
  return GetPokemonList(repository);
});

/// Provider for the Pokémon repository.
/// 
/// This provider creates an instance of [PokemonRepositoryImpl], which is
/// responsible for obtaining Pokémon data through the remote data source.
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  final datasource = ref.read(pokemonRemoteDatasourceProvider);
  return PokemonRepositoryImpl(remoteDatasource: datasource);
});

/// Provider for the remote data source to obtain Pokémon information.
/// 
/// This provider creates an instance of [PokemonRemoteDatasourceImpl]
/// using Dio to make HTTP requests.
final pokemonRemoteDatasourceProvider = Provider<PokemonRemoteDatasource>((ref) {
  final dio = Dio();
  return PokemonRemoteDatasourceImpl(dio: dio);
});
