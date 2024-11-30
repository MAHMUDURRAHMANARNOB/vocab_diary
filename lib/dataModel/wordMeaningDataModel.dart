class WordMeaningDataModel {
  final String? word;
  final String? phonetic;
  final List<Phonetic>? phonetics;
  final List<Meaning>? meanings;
  final License? license;
  final List<String> sourceUrls;

  WordMeaningDataModel({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.meanings,
    required this.license,
    required this.sourceUrls,
  });

  factory WordMeaningDataModel.fromJson(Map<String, dynamic> json) {
    return WordMeaningDataModel(
      word: json['word'],
      phonetic: json['phonetic'],
      phonetics: (json['phonetics'] as List)
          .map((item) => Phonetic.fromJson(item))
          .toList(),
      meanings: (json['meanings'] as List)
          .map((item) => Meaning.fromJson(item))
          .toList(),
      license: License.fromJson(json['license']),
      sourceUrls: List<String>.from(json['sourceUrls']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'phonetic': phonetic,
      'phonetics': phonetics?.map((item) => item.toJson()).toList(),
      'meanings': meanings?.map((item) => item.toJson()).toList(),
      'license': license?.toJson(),
      'sourceUrls': sourceUrls,
    };
  }
}

class Phonetic {
  final String? text;
  final String? audio;
  final String? sourceUrl;

  Phonetic({
    required this.text,
    required this.audio,
    required this.sourceUrl,
  });

  factory Phonetic.fromJson(Map<String, dynamic> json) {
    return Phonetic(
      text: json['text'],
      audio: json['audio'],
      sourceUrl: json['sourceUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'audio': audio,
      'sourceUrl': sourceUrl,
    };
  }
}

class Meaning {
  final String? partOfSpeech;
  final List<Definition>? definitions;
  final List<String>? synonyms;
  final List<String>? antonyms;

  Meaning({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      partOfSpeech: json['partOfSpeech'],
      definitions: (json['definitions'] as List)
          .map((item) => Definition.fromJson(item))
          .toList(),
      synonyms: List<String>.from(json['synonyms']),
      antonyms: List<String>.from(json['antonyms']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'partOfSpeech': partOfSpeech,
      'definitions': definitions?.map((item) => item.toJson()).toList()??"",
      'synonyms': synonyms,
      'antonyms': antonyms,
    };
  }
}

class Definition {
  final String definition;
  final List<String> synonyms;
  final List<String> antonyms;

  Definition({
    required this.definition,
    required this.synonyms,
    required this.antonyms,
  });

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(
      definition: json['definition'],
      synonyms: List<String>.from(json['synonyms']),
      antonyms: List<String>.from(json['antonyms']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'definition': definition,
      'synonyms': synonyms,
      'antonyms': antonyms,
    };
  }
}

class License {
  final String name;
  final String url;

  License({
    required this.name,
    required this.url,
  });

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
