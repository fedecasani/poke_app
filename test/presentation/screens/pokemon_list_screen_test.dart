import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app/domain/entities/pokemon.dart';
import 'package:poke_app/presentation/providers/pokemon_provider.dart';
import 'package:poke_app/presentation/screens/pokemon_list_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/domain/repositories/pokemon_repository.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  testWidgets('should display a list of Pokémon when data is loaded', (WidgetTester tester) async {
    final mockRepository = MockPokemonRepository();

    when(mockRepository.getPokemonList(0)).thenAnswer((_) async => [
      Pokemon(name: 'Pikachu', url: 'https://pokeapi.co/api/v2/pokemon/25', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png'),
      Pokemon(name: 'Charmander', url: 'https://pokeapi.co/api/v2/pokemon/4', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png'),
    ]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pokemonListProvider.overrideWithProvider(
            (offset) => FutureProvider<List<Pokemon>>((ref) {
              return mockRepository.getPokemonList(offset);
            }),
          ),
        ],
        child: MaterialApp(home: PokemonListScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Pikachu'), findsOneWidget);
    expect(find.text('Charmander'), findsOneWidget);
  });

  testWidgets('should show loading indicator while fetching data', (WidgetTester tester) async {
    final mockRepository = MockPokemonRepository();

    when(mockRepository.getPokemonList(0)).thenAnswer((_) async {
      await Future.delayed(Duration(seconds: 2));
      return [
        Pokemon(name: 'Pikachu', url: 'https://pokeapi.co/api/v2/pokemon/25', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png'),
        Pokemon(name: 'Charmander', url: 'https://pokeapi.co/api/v2/pokemon/4', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png'),
      ];
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pokemonListProvider.overrideWithProvider(
            (offset) => FutureProvider<List<Pokemon>>((ref) {
              return mockRepository.getPokemonList(offset);
            }),
          ),
        ],
        child: MaterialApp(home: PokemonListScreen()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
