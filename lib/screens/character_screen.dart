import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character_model.dart';

class CharacterScreen extends StatelessWidget {
  final Character character;

  const CharacterScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(character.name!)),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height:
                  size.height *
                  0.35, //Limitamos la altura de la imagen para que solo ocupe un espacio de la pantalla
              width: double.infinity,
              child: Hero(
                tag: character.id!,
                child: Image.network(character.image!, fit: BoxFit.contain),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: size.height * 0.14,
              width:
                  double
                      .infinity, //Cambiar para que se vea mejor en dispositivos mas anchos
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardData(
                    "Status:",
                    character.statusString,
                  ), // Se usa statusString
                  cardData(
                    "Species:", 
                    character.species!),
                  cardData(
                    "Gender:",
                    character.genderString,
                  ), // Se usa el nuevo getter genderString
                ],
              ),
            ),
            Text(
              'Episodes',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

Widget cardData(String dataTitle, String data) {
  return Expanded(
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(dataTitle),
          Text(data, style: TextStyle(overflow: TextOverflow.ellipsis)),
        ],
      ),
    ),
  );
}

