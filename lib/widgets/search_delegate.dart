import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:rick_and_morty_app/provider/api_provider.dart';

class SearchCharacter extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) { //Maneja las accione que estan a la derecha del buscador
    return [IconButton(onPressed: (){
      query = '';
    }, icon: const Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) { // Maneja las acciones que estan a la izquierda del buscador
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) { // Muestra los resultados de la busqueda
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final characterProvider = Provider.of<ApiProvider>(context);

    Widget circleLoading(){
      return Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/images/portal.gif'),
        ),
      );
    }

    if (query.isEmpty){
      return circleLoading();
    }

    return FutureBuilder(
     future: characterProvider.getCharactersList(query), 
     builder: (context, AsyncSnapshot<List<Character>> snapshot){
      if(!snapshot.hasData){
        return circleLoading();
      }
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index){
          final character = snapshot.data![index];
          return ListTile(
            title: Text(character.name!),
            onTap: (){
              context.go('/character', extra: character);
            },
            leading: Hero(tag: character.id!, child: CircleAvatar(backgroundImage: NetworkImage(character.image!))),
          );
        },
        );
     }
    );
  }
}
