/// Represents a Pokémon with its basic information.
///
/// This class contains the essential attributes of a Pokémon, including
/// its name, URL for accessing its details, and the associated image URL.
class Pokemon {
  /// The name of the Pokémon.
  final String name;

  /// The URL to access the details of the Pokémon.
  final String url;

  /// The URL of the Pokémon's image.
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
