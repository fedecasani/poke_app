import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/data/repositories/pokemon_repository.dart';
import 'package:poke_app/data/datasources/pokemon_remote_datasource.dart';
import 'package:poke_app/data/models/pokemon_model.dart';
import 'package:mockito/mockito.dart';

class MockPokemonRemoteDatasource extends Mock implements PokemonRemoteDatasource {}

void main() {
  late PokemonRepositoryImpl repository;
  late MockPokemonRemoteDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockPokemonRemoteDatasource();
    repository = PokemonRepositoryImpl(remoteDatasource: mockDatasource);
  });

  test('should return a list of PokemonModel when fetching is successful', () async {
    final List<PokemonModel> tPokemonList = [
      PokemonModel(
        name: 'Pikachu',
        url: 'https://pokeapi.co/api/v2/pokemon/25',
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png',
      ),
      PokemonModel(
        name: 'Charmander',
        url: 'https://pokeapi.co/api/v2/pokemon/4',
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      ),
    ];

    when(mockDatasource.fetchPokemonList(0)).thenAnswer((_) async => tPokemonList);

    final result = await repository.getPokemonList(0);

    expect(result, tPokemonList);
    verify(mockDatasource.fetchPokemonList(0));
    verifyNoMoreInteractions(mockDatasource);
  });
}
