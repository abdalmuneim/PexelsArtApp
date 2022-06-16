// To parse this JSON data, do
//
//     final wallpaperModel = wallpaperModelFromJson(jsonString);

import 'dart:convert';

WallpaperModel wallpaperModelFromJson(String str) =>
    WallpaperModel.fromJson(json.decode(str));

class Photos {
  final List<dynamic> photos;

  Photos({required this.photos});

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(photos: json["photos"]);
  }
}

class WallpaperModel {
  WallpaperModel({
    required this.id,
    required this.width,
    required this.height,
    required this.photographer,
    required this.photographerUrl,
    required this.src,
    required this.alt,
  });

  final int id;
  final int width;
  final int height;
  final String photographer;
  final String photographerUrl;
  final Src src;
  final String alt;

  factory WallpaperModel.fromJson(Map<String, dynamic> json) => WallpaperModel(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        photographer: json["photographer"],
        photographerUrl: json["photographer_url"],
        src: Src.fromJson(json["src"]),
        alt: json["alt"],
      );
}

class Src {
  Src({
    required this.original,
    required this.large,
    required this.small,
  });

  final String original;
  final String large;
  final String small;

  factory Src.fromJson(Map<String, dynamic> json) => Src(
        original: json["original"],
        large: json["large"],
        small: json["small"],
      );
}
