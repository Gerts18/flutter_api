import 'package:flutter/widgets.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com';

  List<Character> characters = [];

  Future <void> getCharacters() async {
    final result = await http.get(Uri.https(url, "/api/character")); //Hacemos una llamada del tipo GET al endpoint de personajes
    final response = characterResponseFromJson(result.body);//Parseamos la respuesta con nuestro modelo
    characters.addAll(response.results!); //Almacenamos los resultados
    notifyListeners(); //Notificamos el cambio 
  }

}