import 'package:project_aj/models/enums.dart';

String getTypeForDatabase(ItemType type) {
  switch (type) {
    case ItemType.verbs:
      return 'verbs';
    case ItemType.words:
      return 'words';
    default:
      return 'phrases';
  }
}
