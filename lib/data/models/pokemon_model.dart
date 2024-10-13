import 'package:poke_app/domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel({
    required String name,
    required String url,
    required String imageUrl,
  }) : super(name: name, url: url, imageUrl: imageUrl);

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String;
    final id = url.split('/').reversed.skip(1).first;
    final imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

    return PokemonModel(
      name: json['name'],
      url: url,
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'imageUrl': imageUrl,
    };
  }
}
