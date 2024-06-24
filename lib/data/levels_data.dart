import 'package:project_aj/models/levels_model.dart';

List<Levels> levelsData = [
  Levels(
    purpose: 'slovesa',
    levels: List<Level>.generate(10, (index) {
      return Level(level: index + 1, count: 0);
    }),
  ),
  Levels(
    purpose: 'slovicka',
    levels: List<Level>.generate(10, (index) {
      return Level(level: index + 1, count: 0);
    }),
  ),
  Levels(
    purpose: 'fraze',
    levels: List<Level>.generate(6, (index) {
      return Level(level: index + 1, count: 0);
    }),
  ),
];
