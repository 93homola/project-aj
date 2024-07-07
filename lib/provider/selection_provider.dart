import 'dart:math';
import 'package:flutter/material.dart';
import '../models/data_model.dart';

class SelectionProvider extends ChangeNotifier {
  List<Item> _entryItems = [];

  Item? _actualItem;

  set entryItems(List<Item> items) {
    _entryItems = items;
  }

  Item? get actualItem => _actualItem;

  int get entryItemsCount => _entryItems.length;

  void nextItemFunction() {
    if (_entryItems.isNotEmpty) {
      final random = Random();
      final index = random.nextInt(_entryItems.length);
      final item = _entryItems[index];
      _entryItems.removeAt(index);
      _actualItem = item;
    } else {
      _actualItem = null;
    }
  }

  Item? getActualItem() {
    nextItemFunction();
    return _actualItem;
  }

  void reset() {
    _entryItems = [];
    _actualItem = null;
  }
}
