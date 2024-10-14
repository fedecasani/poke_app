import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entities/stats.dart';
import '../entities/pokemon_details.dart';
import '../entities/ability.dart';
import '../entities/types.dart';

/// Repository for fetching Pokémon details from the API.
///
/// This class provides methods to retrieve detailed information about a Pokémon
/// based on its API URL.
class PokemonDetailsRepository {
  /// Fetches the details of a Pokémon from the API using the provided [url].
  ///
  /// This method sends an HTTP GET request to the specified [url] and expects
  /// a successful response containing the Pokémon's details. If the response
  /// is successful (HTTP status code 200), it parses the JSON and returns a
  /// [PokemonDetails] object.
  ///
  /// Throws an [Exception] if the API call fails or returns an unexpected status code.
  Future<PokemonDetails> fetchPokemonDetails(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Decode the JSON response
      final json = jsonDecode(response.body);

      // Deserialize and return a PokemonDetails object
      return PokemonDetails(
        types: (json['types'] as List)
            .map((type) => Types.fromJson(type)) // Using the Types class
            .toList(),
        height: json['height'],
        weight: json['weight'],
        abilities: (json['abilities'] as List)
            .map((ability) => Ability.fromJson(ability)) // Using the Ability class
            .toList(),
        stats: (json['stats'] as List)
            .map((stat) => Stat.fromJson(stat)) // Using the Stat class
            .toList(),
      );
    } else {
      throw Exception('Failed to load Pokémon details');
    }
  }
}
