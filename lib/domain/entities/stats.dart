/// Represents a statistical measurement of a Pokémon.
///
/// This class contains information about a specific statistic,
/// including its name and base value.
class Stat {
  /// The name of the statistic (e.g., Speed, Attack, Defense).
  final String name;

  /// The base value of the statistic, which indicates the Pokémon's performance.
  final int baseStat;

  /// Creates an instance of [Stat].
  ///
  /// Requires the [name] and [baseStat] of the statistic as mandatory parameters.
  Stat({
    required this.name,
    required this.baseStat,
  });

  /// Creates an instance of [Stat] from a JSON map.
  ///
  /// This factory constructor takes a [Map<String, dynamic>] as input and
  /// returns a new instance of [Stat].
  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      name: json['stat']['name'],
      baseStat: json['base_stat'],
    );
  }
}
