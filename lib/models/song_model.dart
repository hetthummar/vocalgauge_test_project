// {
// "Title":"",
// "Author":"",
// "Collection":"",
// "Year":1964,
// "Mood":"",
// "Pages":200,
// "Rate":"Rate",
// "TeCh":"TeCh",
// "Sets":40,
// "Themes":"Themes",
// "MorF":"M or F",
// "ChLow":{
// "ChLow":"ChLow",
// "TIME":"TIME",
// "syllable":"syllable",
// "word":"word",
// "phrase":"phrase"
// },
// "ChLow":{
// "type":"ChLow",
// "TIME":"TIME",
// "syllable":"syllable",
// "word":"word",
// "phrase":"phrase"
// },
// "ChHigh":{
// "type":"ChHigh",
// "TIME":"TIME",
// "syllable":"syllable",
// "word":"word",
// "phrase":"phrase"
// },
// "HdLow":{
// "type":"HdLow",
// "TIME":"TIME",
// "syllable":"syllable",
// "word":"word",
// "phrase":"phrase"
// },
// "HdHigh":{
// "type":"HdHigh",
// "TIME":"TIME",
// "syllable":"syllable",
// "word":"word",
// "phrase":"phrase"
// },
// "BellLow":{
// "type":"BellLow",
// "TIME":"TIME",
// "syllable":"syllable",
// "word":"word",
// "phrase":"phrase"
// },
// "BellHigh":{
// "type":"BellHigh",
// "TIME":"TIME",
// "syllable":"syllable",
// "word":"word",
// "phrase":"phrase"
// },
// "Thingstonote":"Things to note",
// "Analysis":"Analysis",
// "Youtubelink":"Youtube link"
// }

// To parse this JSON data, do
//
//     final recentChatServerModel = recentChatServerModelFromJson(jsonString);

import 'dart:convert';

RecentChatServerModel recentChatServerModelFromJson(String str) => RecentChatServerModel.fromJson(json.decode(str));

String recentChatServerModelToJson(RecentChatServerModel data) => json.encode(data.toJson());

class RecentChatServerModel {
  RecentChatServerModel({
    required this.title,
    required this.author,
    required this.collection,
    required this.year,
    required this.mood,
    required this.pages,
    required this.rate,
    required this.teCh,
    required this.sets,
    required this.themes,
    required this.morF,
    required this.chLow,
    required this.chHigh,
    required this.hdLow,
    required this.hdHigh,
    required this.bellLow,
    required this.bellHigh,
    required this.thingstonote,
    required this.analysis,
    required this.youtubelink,
  });

  String title;
  String author;
  String collection;
  int year;
  String mood;
  int pages;
  String rate;
  String teCh;
  int sets;
  String themes;
  String morF;
  PhraseSound chLow;
  PhraseSound chHigh;
  PhraseSound hdLow;
  PhraseSound hdHigh;
  PhraseSound bellLow;
  PhraseSound bellHigh;
  String thingstonote;
  String analysis;
  String youtubelink;

  factory RecentChatServerModel.fromJson(Map<String, dynamic> json) => RecentChatServerModel(
    title: json["Title"],
    author: json["Author"],
    collection: json["Collection"],
    year: json["Year"],
    mood: json["Mood"],
    pages: json["Pages"],
    rate: json["Rate"],
    teCh: json["TeCh"],
    sets: json["Sets"],
    themes: json["Themes"],
    morF: json["MorF"],
    chLow: PhraseSound.fromJson(json["ChLow"]),
    chHigh: PhraseSound.fromJson(json["ChHigh"]),
    hdLow: PhraseSound.fromJson(json["HdLow"]),
    hdHigh: PhraseSound.fromJson(json["HdHigh"]),
    bellLow: PhraseSound.fromJson(json["BellLow"]),
    bellHigh: PhraseSound.fromJson(json["BellHigh"]),
    thingstonote: json["Thingstonote"],
    analysis: json["Analysis"],
    youtubelink: json["Youtubelink"],
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "Author": author,
    "Collection": collection,
    "Year": year,
    "Mood": mood,
    "Pages": pages,
    "Rate": rate,
    "TeCh": teCh,
    "Sets": sets,
    "Themes": themes,
    "MorF": morF,
    "ChLow": chLow.toJson(),
    "ChHigh": chHigh.toJson(),
    "HdLow": hdLow.toJson(),
    "HdHigh": hdHigh.toJson(),
    "BellLow": bellLow.toJson(),
    "BellHigh": bellHigh.toJson(),
    "Thingstonote": thingstonote,
    "Analysis": analysis,
    "Youtubelink": youtubelink,
  };
}

class PhraseSound {
  PhraseSound({
    required this.type,
    required this.time,
    required this.syllable,
    required this.word,
    required this.phrase,
  });

  String type;
  String time;
  String syllable;
  String word;
  String phrase;

  factory PhraseSound.fromJson(Map<String, dynamic> json) => PhraseSound(
    type: json["type"],
    time: json["TIME"],
    syllable: json["syllable"],
    word: json["word"],
    phrase: json["phrase"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "TIME": time,
    "syllable": syllable,
    "word": word,
    "phrase": phrase,
  };
}

