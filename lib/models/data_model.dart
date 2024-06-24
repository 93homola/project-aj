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

class Rule {
  final int level;

  Rule({required this.level});

  factory Rule.fromJson(Map<String, dynamic> json) {
    return Rule(
      level: json['level'],
    );
  }
}

class DatabaseData {
  final List<Verb> verbs;
  final List<Word> words;
  final List<Rule> verbsRules;
  final List<Rule> wordsRules;

  DatabaseData(
      {required this.verbs,
      required this.words,
      required this.verbsRules,
      required this.wordsRules});

  factory DatabaseData.fromJson(Map<String, dynamic> json) {
    List<Verb> verbs = [];
    List<Word> words = [];
    List<Rule> verbsRules = [];
    List<Rule> wordsRules = [];

    if (json.containsKey('verbs')) {
      verbs = (json['verbs'] as List).map((v) {
        Map<String, dynamic> verbMap = Map<String, dynamic>.from(v as Map);
        return Verb.fromJson(verbMap);
      }).toList();
    }
    if (json.containsKey('words')) {
      words = (json['words'] as List).map((w) {
        Map<String, dynamic> wordMap = Map<String, dynamic>.from(w as Map);
        return Word.fromJson(wordMap);
      }).toList();
    }
    if (json.containsKey('verbsRules')) {
      verbsRules = (json['verbsRules'] as List).map((v) {
        Map<String, dynamic> verbsRulesMap =
            Map<String, dynamic>.from(v as Map);
        return Rule.fromJson(verbsRulesMap);
      }).toList();
    }
    if (json.containsKey('wordsRules')) {
      wordsRules = (json['wordsRules'] as List).map((w) {
        Map<String, dynamic> wordsRulesMap =
            Map<String, dynamic>.from(w as Map);
        return Rule.fromJson(wordsRulesMap);
      }).toList();
    }

    return DatabaseData(
      verbs: verbs,
      words: words,
      verbsRules: verbsRules,
      wordsRules: wordsRules,
    );
  }
}
