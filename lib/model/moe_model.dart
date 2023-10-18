// To parse this JSON data, do
//
//     final moeModel = moeModelFromJson(jsonString);

import 'dart:convert';

MoeModel moeModelFromJson(String str) => MoeModel.fromJson(json.decode(str));

String moeModelToJson(MoeModel data) => json.encode(data.toJson());

class MoeModel {
  int? frameCount;
  String? error;
  List<Result>? result;

  MoeModel({
    this.frameCount,
    this.error,
    this.result,
  });

  factory MoeModel.fromJson(Map<String, dynamic> json) => MoeModel(
        frameCount: json["frameCount"],
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
  int? anilist;
  String? filename;
  int? episode;
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
        anilist: json["anilist"],
        filename: json["filename"],
        episode: json["episode"],
        from: json["from"]?.toDouble(),
        to: json["to"]?.toDouble(),
        similarity: json["similarity"]?.toDouble(),
        video: json["video"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "anilist": anilist,
        "filename": filename,
        "episode": episode,
        "from": from,
        "to": to,
        "similarity": similarity,
        "video": video,
        "image": image,
      };
}
