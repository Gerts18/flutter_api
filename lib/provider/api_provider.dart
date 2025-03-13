import 'package:flutter/widgets.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/models/episode_model.dart';
import 'dart:convert';

class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com';

  List<Character> characters = [];
  List<Episode> episodes = [];

  Future<void> getCharacters(int page) async {
    try {
      final result = await http.get(
        Uri.https(url, "/api/character", {"page": page.toString()}),
      );
      final response = characterResponseFromJson(result.body);
      characters.addAll(response.results!);
      notifyListeners();
    } catch (e) {
      // Manejo de error
      print('Error al obtener personajes: $e');
    }
  }

  Future<List<Episode>> getEpisodes(Character character) async {
    episodes = [];
    for (var episodeUrl in character.episode!) {
      final result = await http.get(Uri.parse(episodeUrl));
      // Se parsea la respuesta directamente a un Episode
      final episode = Episode.fromJson(json.decode(result.body));
      episodes.add(episode);
      notifyListeners();
    }
    return episodes;
  }
}
