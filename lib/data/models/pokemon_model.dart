import 'package:poke_app/domain/entities/pokemon.dart';

/// A model that represents a Pokémon, extending the [Pokemon] class.
///
/// This model includes additional functionalities such as serialization
/// and deserialization from/to JSON.
class PokemonModel extends Pokemon {
  /// Constructor for [PokemonModel].
  /// 
  /// Takes the [name], [url], and [imageUrl] of the Pokémon. Calls the
  /// constructor of the parent class [Pokemon].
  // ignore: use_super_parameters
  PokemonModel({
    required String name,
    required String url,
    required String imageUrl,
  }) : super(name: name, url: url, imageUrl: imageUrl);

  /// Creates an instance of [PokemonModel] from JSON.
  /// 
  /// This factory constructor processes the [url] field from the JSON
  /// to extract the Pokémon ID and generate the corresponding [imageUrl].
  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String;
    final id = url.split('/').reversed.skip(1).first; // Extract Pokémon ID from URL
    final imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

    return PokemonModel(
      name: json['name'],
      url: url,
      imageUrl: imageUrl,
    );
  }

  /// Converts an instance of [PokemonModel] to a JSON map.
  /// 
  /// Returns a [Map] with the keys `name`, `url`, and `imageUrl`.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'imageUrl': imageUrl,
    };
  }
}
