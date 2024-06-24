abstract class LanguageItem {
  final String cs;
  final String en;
  final int level;
  final int id;

  LanguageItem({
    required this.cs,
    required this.en,
    required this.level,
    required this.id,
  });

  Map<String, dynamic> toJson();
}

class Verb extends LanguageItem {
  Verb({
    required super.cs,
    required super.en,
    required super.level,
    required super.id,
  });

  factory Verb.fromJson(Map<String, dynamic> json) {
    return Verb(
      cs: json['cs'],
      en: json['en'],
      level: json['level'],
      id: json['id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'cs': cs,
      'en': en,
      'level': level,
      'id': id,
      'type': 'verb',
    };
  }
}

class Word extends LanguageItem {
  Word({
    required super.cs,
    required super.en,
    required super.level,
    required super.id,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'cs': cs,
      'en': en,
      'level': level,
      'id': id,
      'type': 'word',
    };
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      cs: json['cs'],
      en: json['en'],
      level: json['level'],
      id: json['id'],
    );
  }
}

class Items {
  final List<Verb> verbs;
  final List<Word> words;

  Items({required this.verbs, required this.words});

  factory Items.fromJson(Map<String, dynamic> json) {
    List<Verb> verbs = [];
    List<Word> words = [];

    if (json.containsKey('type') && json['type'].containsKey('verbs')) {
      verbs = (json['type']['verbs'] as List).map((v) {
        Map<String, dynamic> verbMap = Map<String, dynamic>.from(v as Map);
        return Verb.fromJson(verbMap);
      }).toList();
      words = (json['type']['words'] as List).map((w) {
        Map<String, dynamic> wordMap = Map<String, dynamic>.from(w as Map);
        return Word.fromJson(wordMap);
      }).toList();
    } else {}
    return Items(verbs: verbs, words: words);
  }

  List<dynamic> toJson() {
    return verbs.map((verb) => verb.toJson()).toList();
  }
}

/* class Items {
  final List<Item> items;

  Items({required this.items});

  factory Items.fromJson(List<dynamic> json) {
    List<Item> items = json.map((i) {
      Map<String, dynamic> itemMap = Map<String, dynamic>.from(i as Map);
      return Item.fromJson(itemMap);
    }).toList();

    return Items(items: items);
  }

  List<dynamic> toJson() {
    return items.map((item) => item.toJson()).toList();
  }
} */
