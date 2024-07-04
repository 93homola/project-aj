class Verb {
  final String cs;
  final String en;
  final int level;
  final int id;
  final String type = 'verb';

  Verb({
    required this.cs,
    required this.en,
    required this.level,
    required this.id,
  });

  factory Verb.fromJson(Map<String, dynamic> json) {
    return Verb(
      cs: json['cs'],
      en: json['en'],
      level: json['level'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cs': cs,
      'en': en,
      'level': level,
      'id': id,
      'type': type,
    };
  }
}

class Word {
  final String cs;
  final String en;
  final int level;
  final int id;
  final String type = 'word';

  Word({
    required this.cs,
    required this.en,
    required this.level,
    required this.id,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      cs: json['cs'],
      en: json['en'],
      level: json['level'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cs': cs,
      'en': en,
      'level': level,
      'id': id,
      'type': type,
    };
  }
}

class Verbs {
  final List<Verb> verbList;

  Verbs({required this.verbList});

  Map<String, dynamic> toJson() {
    return {
      'verbs': verbList.map((verb) => verb.toJson()).toList(),
    };
  }

  factory Verbs.fromJson(List<dynamic> jsonList) {
    List<Verb> verbs = jsonList.map((json) {
      Map<String, dynamic> jsonMap = Map<String, dynamic>.from(json as Map);
      return Verb.fromJson(jsonMap);
    }).toList();
    return Verbs(verbList: verbs);
  }
}

class Words {
  final List<Word> wordList;

  Words({required this.wordList});

  Map<String, dynamic> toJson() {
    return {
      'words': wordList.map((word) => word.toJson()).toList(),
    };
  }

  factory Words.fromJson(List<dynamic> jsonList) {
    List<Word> words = jsonList.map((json) {
      Map<String, dynamic> jsonMap = Map<String, dynamic>.from(json as Map);
      return Word.fromJson(jsonMap);
    }).toList();
    return Words(wordList: words);
  }
}
