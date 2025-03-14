import 'package:flutter/widgets.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/models/episode_model.dart';
import 'dart:convert';

// Clase que se encarga de manejar la lógica de la API

class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com'; // URL de la API

  List<Character> characters = []; // Lista de personajes
  List<Episode> episodes = []; // Lista de episodios

  //Metodo que se encarga de obtener los personajes de la API
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

  //Metodo que se encarga de obtener los episodios de un personaje
  Future<List<Episode>> getEpisodes(Character character) async {
    episodes = [];
    try {
      for (var episodeUrl in character.episode!) {
        final result = await http.get(Uri.parse(episodeUrl));
        // Se parsea la respuesta directamente a un Episode
        final episode = Episode.fromJson(json.decode(result.body));
        episodes.add(episode);
        notifyListeners();
      }
    } catch (e) {
      print('Error al obtener episodios: $e');
    }
    return episodes;
  }

  //Metodo que se encarga de devolver una lista de personajes
  Future<List<Character>> getCharactersList(String name) async {
    try {
      final result = await http.get(
        Uri.https(url, "/api/character/", {"name": name}),
      );
      final response = characterResponseFromJson(result.body);
      return response.results!;
    } 
    catch (e) {
      print('Error al obtener personajes: $e');
    }
    return [];
  }
}
