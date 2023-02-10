// To parse this JSON data, do
//
//     final truthOrDare = truthOrDareFromMap(jsonString);

import 'dart:convert';

TruthOrDare truthOrDareFromMap(String str) =>
    TruthOrDare.fromMap(json.decode(str));

String truthOrDareToMap(TruthOrDare data) => json.encode(data.toMap());

class TruthOrDare {
  TruthOrDare({
    this.id,
    this.type,
    this.rating,
    this.question,
    this.translations,
  });

  String? id;
  String? type;
  String? rating;
  String? question;
  Translations? translations;

  factory TruthOrDare.fromMap(Map<String, dynamic> json) => TruthOrDare(
        id: json["id"],
        type: json["type"],
        rating: json["rating"],
        question: json["question"],
        translations: Translations.fromMap(json["translations"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "rating": rating,
        "question": question,
        "translations": translations?.toMap(),
      };
}

class Translations {
  Translations({
    this.bn,
    this.de,
    this.es,
    this.fr,
    this.hi,
    this.tl,
  });

  String? bn;
  String? de;
  String? es;
  String? fr;
  String? hi;
  String? tl;

  factory Translations.fromMap(Map<String, dynamic> json) => Translations(
        bn: json["bn"],
        de: json["de"],
        es: json["es"],
        fr: json["fr"],
        hi: json["hi"],
        tl: json["tl"],
      );

  Map<String, dynamic> toMap() => {
        "bn": bn,
        "de": de,
        "es": es,
        "fr": fr,
        "hi": hi,
        "tl": tl,
      };
}
