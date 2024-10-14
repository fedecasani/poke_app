/// Represents a Pokémon type.
///
/// This class contains information about a specific type,
/// including its name, which is crucial for determining
/// the strengths and weaknesses of a Pokémon in battles.
class Types {
  /// The name of the Pokémon type (e.g., Fire, Water, Grass).
  final String name;

  /// Creates an instance of [Types].
  ///
  /// Requires the [name] of the type as a mandatory parameter.
  Types({required this.name});

  /// Creates an instance of [Types] from a JSON map.
  ///
  /// This factory constructor takes a [Map<String, dynamic>] as input
  /// and returns a new instance of [Types].
  factory Types.fromJson(Map<String, dynamic> json) {
    return Types(name: json['type']['name']);
  }
}
