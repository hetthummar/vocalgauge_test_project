// To parse required this. JSON data, do
//
//     final songTestmodel = songTestmodelFromJson(jsonString);

import 'dart:convert';

SongTestmodel songTestmodelFromJson(String str) => SongTestmodel.fromJson(json.decode(str));

String songTestmodelToJson(SongTestmodel data) => json.encode(data.toJson());

class SongTestmodel {
  SongTestmodel({
    required this.title,
    required this.author,
    required this.collection,
    required this.year,
    required this.mood,
    required this.pages,
    required this.rate,
    required this.stOrSw,
    required this.teCh,
    required this.keCh,
    required this.sets,
    required this.themes,
    required this.morF,
    required this.thingstonote,
    required this.analysis,
    required this.youtubelink,

    required this.chLow,
    required this.chHigh,
    required this.hdLow,
    required this.hdHigh,
    required this.bellLow,
    required this.bellHigh,
  });

  String title;
  String author;
  String collection;
  int year;
  String mood;
  int pages;
  String rate;
  String stOrSw;
  bool teCh;
  bool keCh;
  int sets;
  List<String> themes;
  String morF;

  String thingstonote;
  String analysis;
  String youtubelink;

  HighOrLow chLow;
  HighOrLow chHigh;
  HighOrLow hdLow;
  HighOrLow hdHigh;
  HighOrLow bellLow;
  HighOrLow bellHigh;

  factory SongTestmodel.fromJson(Map<String, dynamic> json) => SongTestmodel(
    title: json["Title"],
    author: json["Author"],
    collection: json["Collection"],
    year: json["Year"],
    mood: json["Mood"],
    pages: json["Pages"],
    rate: json["Rate"],
    stOrSw: json["StOrSw"],
    teCh: json["TeCh"],
    keCh: json["keCh"],
    sets: json["Sets"],
    themes: json["Themes"],
    morF: json["MorF"],
    thingstonote: json["Thingstonote"],
    analysis: json["Analysis"],
    youtubelink: json["Youtubelink"],

    chLow: json["chLow"],
    chHigh: json["chHigh"],
    hdLow: json["hdLow"],
    hdHigh: json["hdHigh"],
    bellLow: json["bellLow"],
    bellHigh: json["bellHigh"],
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "Author": author,
    "Collection": collection,
    "Year": year,
    "Mood": mood,
    "Pages": pages,
    "Rate": rate,
    "StOrSw": stOrSw,
    "TeCh": teCh,
    "keCh": keCh,
    "Sets": sets,
    "Themes": themes,
    "MorF": morF,
    "Thingstonote": thingstonote,
    "Analysis": analysis,
    "Youtubelink": youtubelink,

    "chLow": chLow.toJson(),
    "chHigh": chHigh.toJson(),
    "hdLow": hdLow.toJson(),
    "hdHigh": hdHigh.toJson(),
    "bellLow": bellLow.toJson(),
    "bellHigh": bellHigh.toJson(),
  };
}


class HighOrLow {

  String type;
  String time;
  String syllable;
  String word;
  String phrase;

  HighOrLow({
    required this.type,
    required this.time,
    required this.syllable,
    required this.word,
    required this.phrase,
  });

  factory HighOrLow.fromJson(Map<String, dynamic> json) => HighOrLow(
    type: json["type"],
    time: json["time"],
    syllable: json["syllable"],
    word: json["word"],
    phrase: json["phrase"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "time": time,
    "syllable": syllable,
    "word": word,
    "phrase": phrase,
  };
}
