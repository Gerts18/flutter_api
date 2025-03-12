// To parse this JSON data, do
//
//     final episodeResponse = episodeResponseFromJson(jsonString);

import 'dart:convert';

EpisodeResponse episodeResponseFromJson(String str) => EpisodeResponse.fromJson(json.decode(str));

String episodeResponseToJson(EpisodeResponse data) => json.encode(data.toJson());

class EpisodeResponse {
    int? id;
    String? name;
    String? airDate;
    String? episode;
    List<String>? characters;
    String? url;
    DateTime? created;

    EpisodeResponse({
        this.id,
        this.name,
        this.airDate,
        this.episode,
        this.characters,
        this.url,
        this.created,
    });

    factory EpisodeResponse.fromJson(Map<String, dynamic> json) => EpisodeResponse(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: json["characters"] == null ? [] : List<String>.from(json["characters"]!.map((x) => x)),
        url: json["url"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode": episode,
        "characters": characters == null ? [] : List<dynamic>.from(characters!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
    };
}
