/// Represents a Pokémon ability.
///
/// This class contains the name of the ability and provides a method
/// to create an instance from a JSON object.
class Ability {
  /// The name of the ability.
  final String name;

  /// Creates an instance of [Ability].
  ///
  /// The [name] parameter is required to initialize the ability.
  Ability({required this.name});

  /// Creates an instance of [Ability] from a JSON object.
  ///
  /// The [json] parameter must contain a map with the key 'ability',
  /// which contains another map with the key 'name'.
  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(name: json['ability']['name']);
  }
}
