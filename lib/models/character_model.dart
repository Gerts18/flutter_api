// Modelo para mostrar los datos de un personaje 
//
//     final characterResponse = characterResponseFromJson(jsonString);

import 'dart:convert';

CharacterResponse characterResponseFromJson(String str) => CharacterResponse.fromJson(json.decode(str));

String characterResponseToJson(CharacterResponse data) => json.encode(data.toJson());

class CharacterResponse {
    Info? info;
    List<Character>? results;

    CharacterResponse({
        this.info,
        this.results,
    });

    factory CharacterResponse.fromJson(Map<String, dynamic> json) => CharacterResponse(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null ? [] : List<Character>.from(json["results"]!.map((x) => Character.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Info {
    int? count;
    int? pages;
    String? next;
    dynamic prev;

    Info({
        this.count,
        this.pages,
        this.next,
        this.prev,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
    };
}

class Character {
    int? id;
    String? name;
    Status? status;
    String? species;
    String? type;
    Gender? gender;
    Location? origin;
    Location? location;
    String? image;
    List<String>? episode;
    String? url;
    DateTime? created;

    Character({
        this.id,
        this.name,
        this.status,
        this.species,
        this.type,
        this.gender,
        this.origin,
        this.location,
        this.image,
        this.episode,
        this.url,
        this.created,
    });

    // Getter para retornar status como string
    String get statusString => statusValues.reverse[status] ?? '';

    // Nuevo getter para retornar gender como string
    String get genderString => genderValues.reverse[gender] ?? '';

    factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]]!,
        species: json["species"],
        type: json["type"],
        gender: genderValues.map[json["gender"]]!,
        origin: json["origin"] == null ? null : Location.fromJson(json["origin"]),
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        image: json["image"],
        episode: json["episode"] == null ? [] : List<String>.from(json["episode"]!.map((x) => x)),
        url: json["url"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": species,
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin?.toJson(),
        "location": location?.toJson(),
        "image": image,
        "episode": episode == null ? [] : List<dynamic>.from(episode!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
    };
}

enum Gender {
    FEMALE,
    MALE,
    UNKNOWN
}

final genderValues = EnumValues({
    "Female": Gender.FEMALE,
    "Male": Gender.MALE,
    "unknown": Gender.UNKNOWN
});

class Location {
    String? name;
    String? url;
    String? species;

    Location({
        this.name,
        this.url,
        this.species
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
        species: json["species"]
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

enum Status {
    ALIVE,
    DEAD,
    UNKNOWN
}

final statusValues = EnumValues({
    "Alive": Status.ALIVE,
    "Dead": Status.DEAD,
    "unknown": Status.UNKNOWN
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
