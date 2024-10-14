import 'package:poke_app/domain/entities/types.dart';
import 'package:poke_app/domain/entities/ability.dart';
import 'package:poke_app/domain/entities/stats.dart';

/// Represents detailed information about a Pokémon.
///
/// This class contains the attributes that provide specific details
/// about a Pokémon, including its types, height, weight, abilities,
/// and stats.
class PokemonDetails {
  /// The types of the Pokémon (e.g., Fire, Water, Grass).
  final List<Types> types;

  /// The height of the Pokémon in decimeters.
  final int height;

  /// The weight of the Pokémon in hectograms.
  final int weight;

  /// The abilities of the Pokémon, which can affect its performance.
  final List<Ability> abilities;

  /// The stats of the Pokémon, representing various performance metrics.
  final List<Stat> stats;

  /// Creates an instance of [PokemonDetails].
  ///
  /// Requires the [types], [height], [weight], [abilities], and [stats]
  /// of the Pokémon as mandatory parameters to initialize the object.
  PokemonDetails({
    required this.types,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.stats,
  });
}
