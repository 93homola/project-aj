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

  int getItemsCount(ItemType type) {
    if (type == ItemType.verbs) {
      return _verbs.verbList.length;
    } else {
      return _words.wordList.length;
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

  Future<void> deleteItem(Item item, ItemType type) async {
    database.child('/${type.name}/${item.id}').remove();
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

  List<Item> getFilterItems(ItemType type, {String? firstWords}) {
    List<Item> items;
    if (type == ItemType.verbs) {
      items = _verbs.verbList;
    } else {
      items = _words.wordList;
    }

    if (firstWords != null && firstWords.isNotEmpty) {
      items = items.where((item) => item.cs.startsWith(firstWords)).toList();
    }

    return items;
  }

  updateHistory(ItemType type) async {
    String today = DateTime.now().toIso8601String().split('T').first;

    DatabaseEvent databaseEvent =
        await database.child('/history/$today/${type.name}').once();

    int value = databaseEvent.snapshot.value != null
        ? databaseEvent.snapshot.value as int
        : 0;

    value = value + 1;

    database.child('/history/$today').update({type.name: value});
  }

  Future<History> loadHistory() async {
    DatabaseEvent historyFromDatabase = await database.child('/history').once();

    History history = History.fromJson(Map<String, dynamic>.from(
            historyFromDatabase.snapshot.value as Map))
        .sortedByDate();

    return history;
  }
}
