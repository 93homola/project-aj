import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project_aj/models/data_model.dart';

class FirebaseDataProvider extends ChangeNotifier {
  DatabaseData _items = DatabaseData(
    verbs: [],
    words: [],
    verbsRules: [],
    wordsRules: [],
  );

  List<Verb> get verbs => _items.verbs;

  List<Word> get words => _items.words;

  List<Rule> getRulesByName(String rulesName) {
    if (rulesName == 'slovesa') {
      return _items.verbsRules;
    } else if (rulesName == 'slovicka') {
      return _items.wordsRules;
    } else {
      return [];
    }
  }

  final dbRef = FirebaseDatabase.instance.ref();

  Future<void> loadData() async {
    DatabaseEvent snapshot = await dbRef.once();

    _items = DatabaseData.fromJson(
        (snapshot.snapshot.value as Map).cast<String, dynamic>());

    notifyListeners();
  }
}
