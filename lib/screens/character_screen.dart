import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:rick_and_morty_app/provider/api_provider.dart';

// Pantalla que muestra la información de un personaje en especifico

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
              width: size.width * 0.9,
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
            EpisodesList(size: size, character: character)
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

class EpisodesList extends StatefulWidget {
  const EpisodesList({super.key, required this.size, required this.character});

  final Size size;
  final Character character;

  @override
  State<EpisodesList> createState() => _EpisodesListState();
}

class _EpisodesListState extends State<EpisodesList> {

  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getEpisodes(widget.character);
  }


  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    return SizedBox(
      height: widget.size.height * 0.35,
      width: widget.size.width * 0.9,
      child: ListView.builder(
          itemCount: apiProvider.episodes.length,
          itemBuilder: (context, index){
            final episode = apiProvider.episodes[index];
            return ListTile(
              leading: Text(episode.episode!),
              title: Text(episode.name!),
              trailing: Text(episode.airDate!),
            );
          },
        ),
    );
  }
}