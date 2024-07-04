import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_aj/helpers/functions.dart';
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

  Future<void> loadData(ItemType type) async {
    DatabaseEvent itemsFromDatabase =
        await database.child('/${getTypeForDatabase(type)}').once();

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

  Future<void> editItem(Verb item, ItemType type) async {
    database
        .child('/${getTypeForDatabase(type)}/${item.id}')
        .set(item.toJson());
  }

  Future<void> deleteItem(Verb item, ItemType type) async {
    database.child('/items/${item.id}').remove();
  }

  Future<void> updateLevel(Verb item, ItemType type, int newLevel) async {
    database.child('/items/${item.id}').update({'level': newLevel});
  }
}
