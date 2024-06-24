import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project_aj/models/item_model.dart';

class FirebaseDataProvider extends ChangeNotifier {
  Items _items = Items(verbs: [], words: []);

  List<Verb> get verbs => _items.verbs;

  List<Word> get words => _items.words;

  final dbRef = FirebaseDatabase.instance.ref();

  Future<void> loadData() async {
    DatabaseEvent snapshot = await dbRef.once();

    _items = Items.fromJson(
        (snapshot.snapshot.value as Map).cast<String, dynamic>());

    notifyListeners();
  }
}
