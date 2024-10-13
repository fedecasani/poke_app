/// Represents a Pokémon with its basic information.
///
/// This class contains the essential attributes of a Pokémon, including
/// its name, URL, and the associated image URL.
class Pokemon {
  final String name;      /// The name of the Pokémon.
  final String url;       /// The URL to access the details of the Pokémon.
  final String imageUrl;  /// The URL of the Pokémon's image.

  /// Constructor for [Pokemon].
  ///
  /// Requires the [name], [url], and [imageUrl] of the Pokémon as mandatory
  /// parameters.
  Pokemon({
    required this.name,
    required this.url,
    required this.imageUrl,
  });
}
