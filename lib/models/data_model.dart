abstract class Item {
  String get cs;
  String get en;
  int get level;
  int get id;
  String get type;
}

class Verb implements Item {
  @override
  final String cs;
  @override
  final String en;
  @override
  final int level;
  @override
  final int id;
  @override
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

class Word implements Item {
  @override
  final String cs;
  @override
  final String en;
  @override
  final int level;
  @override
  final int id;
  @override
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

class Settings {
  final int verbsLevels;
  final int wordsLevels;

  Settings({
    required this.verbsLevels,
    required this.wordsLevels,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      verbsLevels: json['verbsLevels'],
      wordsLevels: json['wordsLevels'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'verbsLevels': verbsLevels,
      'wordsLevels': wordsLevels,
    };
  }
}

class HistoryEntry {
  final int? verbs;
  final int? words;

  HistoryEntry({
    required this.verbs,
    required this.words,
  });

  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    return HistoryEntry(
      verbs: json['verbs'],
      words: json['words'],
    );
  }
}

class History {
  final Map<String, HistoryEntry> days;

  History({
    required this.days,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    Map<String, HistoryEntry> days = {};
    json.forEach((key, value) {
      days[key] = HistoryEntry.fromJson(Map<String, dynamic>.from(value));
    });
    return History(days: days);
  }

  History sortedByDate() {
    var sortedKeys = days.keys.toList()
      ..sort((a, b) => DateTime.parse(b).compareTo(DateTime.parse(a)));

    Map<String, HistoryEntry> sortedDays = {
      for (var key in sortedKeys) key: days[key]!
    };

    return History(days: sortedDays);
  }
}
