// To parse this JSON data, do
//
//     final traceModel = traceModelFromJson(jsonString);

import 'dart:convert';

TraceModel traceModelFromJson(String str) =>
    TraceModel.fromJson(json.decode(str));

String traceModelToJson(TraceModel data) => json.encode(data.toJson());

class TraceModel {
  String? frameCount;
  String? error;
  List<Result>? result;

  TraceModel({
    this.frameCount,
    this.error,
    this.result,
  });

  factory TraceModel.fromJson(Map<String, dynamic> json) => TraceModel(
        frameCount: json["frameCount"].toString(),
        error: json["error"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "frameCount": frameCount,
        "error": error,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  Anilist? anilist;
  String? filename;
  String? episode;
  double? from;
  double? to;
  double? similarity;
  String? video;
  String? image;

  Result({
    this.anilist,
    this.filename,
    this.episode,
    this.from,
    this.to,
    this.similarity,
    this.video,
    this.image,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        anilist:
            json["anilist"] == null ? null : Anilist.fromJson(json["anilist"]),
        filename: json["filename"],
        episode: json["episode"].toString(),
        from: json["from"]?.toDouble(),
        to: json["to"]?.toDouble(),
        similarity: json["similarity"]?.toDouble(),
        video: json["video"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "anilist": anilist?.toJson(),
        "filename": filename,
        "episode": episode,
        "from": from,
        "to": to,
        "similarity": similarity,
        "video": video,
        "image": image,
      };
}

class Anilist {
  int? id;
  int? idMal;
  Title? title;
  List<String>? synonyms;
  bool? isAdult;

  Anilist({
    this.id,
    this.idMal,
    this.title,
    this.synonyms,
    this.isAdult,
  });

  factory Anilist.fromJson(Map<String, dynamic> json) => Anilist(
        id: json["id"],
        idMal: json["idMal"],
        title: json["title"] == null ? null : Title.fromJson(json["title"]),
        synonyms: json["synonyms"] == null
            ? []
            : List<String>.from(json["synonyms"]!.map((x) => x)),
        isAdult: json["isAdult"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idMal": idMal,
        "title": title?.toJson(),
        "synonyms":
            synonyms == null ? [] : List<dynamic>.from(synonyms!.map((x) => x)),
        "isAdult": isAdult,
      };
}

class Title {
  String? native;
  String? romaji;
  String? english;

  Title({
    this.native,
    this.romaji,
    this.english,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        native: json["native"],
        romaji: json["romaji"],
        english: json["english"],
      );

  Map<String, dynamic> toJson() => {
        "native": native,
        "romaji": romaji,
        "english": english,
      };
}
