class Levels {
  final List<Level> levels;
  final String purpose;

  Levels({
    required this.levels,
    required this.purpose,
  });
}

class Level {
  final int level;

  final int count;

  Level({
    required this.level,
    required this.count,
  });
}
