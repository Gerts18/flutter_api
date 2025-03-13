import 'package:flutter/widgets.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com';

  List<Character> characters = [];

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
}
