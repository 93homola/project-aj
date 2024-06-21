import 'package:flutter/material.dart';

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
  final Color color;
  final int count;

  Level({
    required this.level,
    required this.color,
    required this.count,
  });
}
