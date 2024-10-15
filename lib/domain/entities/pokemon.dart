import 'package:hive/hive.dart';

part 'pokemon.g.dart'; // Este archivo se generará automáticamente

/// Represents a Pokémon with its basic information.
/// 
/// This class contains the essential attributes of a Pokémon, including
/// its name, URL for accessing its details, and the associated image URL.
@HiveType(typeId: 0) // Asegúrate de usar un ID único
class Pokemon {
  /// The name of the Pokémon.
  @HiveField(0)
  final String name;

  /// The URL to access the details of the Pokémon.
  @HiveField(1)
  final String url;

  /// The URL of the Pokémon's image.
  @HiveField(2)
  final String imageUrl;

  /// Creates an instance of [Pokemon].
  /// 
  /// Requires the [name], [url], and [imageUrl] of the Pokémon as mandatory
  /// parameters to initialize the object.
  Pokemon({
    required this.name,
    required this.url,
    required this.imageUrl,
  });
}
