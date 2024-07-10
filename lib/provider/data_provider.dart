import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_aj/models/data_model.dart';
import 'package:project_aj/models/enums.dart';

class FirebaseDataProvider extends ChangeNotifier {
  Verbs _verbs = Verbs(
    verbList: [],
  );

  Words _words = Words(
    wordList: [],
  );

  Settings? _settings;

  List<Verb> get verbs => _verbs.verbList;

  List<Word> get words => _words.wordList;

  Settings? get settings => _settings;

  final database = FirebaseDatabase.instance.ref();

  int getLevelsCount(ItemType type) {
    if (type == ItemType.verbs) {
      return _settings!.verbsLevels;
    } else {
      return _settings!.wordsLevels;
    }
  }

  List<Item> getItemsForLevel(int level, ItemType type) {
    if (type == ItemType.verbs) {
      return _verbs.verbList.where((verb) => verb.level == level).toList();
    } else {
      return _words.wordList.where((word) => word.level == level).toList();
    }
  }

  Future<void> loadData(ItemType type) async {
    DatabaseEvent itemsFromDatabase =
        await database.child('/${type.name}').once();

    if (type == ItemType.verbs) {
      _verbs =
          Verbs.fromJson(itemsFromDatabase.snapshot.value as List<dynamic>);
    } else {
      _words =
          Words.fromJson(itemsFromDatabase.snapshot.value as List<dynamic>);
    }
  }

  Future<void> loadSettings() async {
    DatabaseEvent itemsFromDatabase = await database.child('/settings').once();

    _settings = Settings.fromJson(
        (itemsFromDatabase.snapshot.value as Map).cast<String, dynamic>());
  }

  Future<void> loadAllData() async {
    await Future.wait([
      loadData(ItemType.verbs),
      loadData(ItemType.words),
      loadSettings(),
    ]);
  }

  Future<void> editItem(
      {required String cs,
      required String en,
      required int level,
      required int id,
      required ItemType type}) async {
    if (type == ItemType.verbs) {
      final item = Verb(
        cs: cs,
        en: en,
        level: level,
        id: id,
      );
      database.child('/${type.name}/${item.id}').set(item.toJson());
    }
    if (type == ItemType.words) {
      final item = Word(
        cs: cs,
        en: en,
        level: level,
        id: id,
      );
      database.child('/${type.name}/${item.id}').set(item.toJson());
    }
  }

  Future<void> deleteItem(Verb item, ItemType type) async {
    database.child('/items/${item.id}').remove();
  }

  Future<void> updateItemLevel(Item item, ItemType type, int newLevel) async {
    database.child('/${type.name}/${item.id}').update({'level': newLevel});
  }

  getSettingsCount(ItemType type) {
    if (type == ItemType.verbs) {
      return _settings!.verbsLevels;
    }
    if (type == ItemType.words) {
      return _settings!.wordsLevels;
    }
    /* if (type == ItemType.phrases) {
      return _settings!.phrasesLevels;
    } */
    return _settings!.verbsLevels;
  }
}
