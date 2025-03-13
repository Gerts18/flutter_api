import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/provider/api_provider.dart';

/* Pantalla principal de la aplicación donde se mostrara una lista de todos los personajes de la serie Rick and Morty. */

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final scrollControler = ScrollController(  );
  bool isLoading = false;
  int page = 1;

  @override /*Esto lo ponemos para que en cuanto se dibuje el widget se pueda llamar a la Api */
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getCharacters(page); //Obtenemos los personajes
    scrollControler.addListener(() async {
      if(scrollControler.position.pixels == scrollControler.position.maxScrollExtent){ //Si ya estamos en el final de la pagina
        setState(() {
          isLoading = true;
        });
        page ++;
        await apiProvider.getCharacters(page);
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rick and Morty Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child:
            apiProvider.characters.isNotEmpty
                ? CharacterList(
                  apiProvider: apiProvider,
                  scrollController: scrollControler,
                  isLoading: isLoading,
                ) //En caso de que la lista no este vacia vamos a cargar la lista de personajes
                : Center(
                  child:
                      CircularProgressIndicator(), //Si la lista esta vacia, vamos a mostrar un indicador de carga
                ),
      ), 
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({super.key, required this.apiProvider, required this.scrollController, required this.isLoading});

  final ApiProvider apiProvider;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10
            
          ), //La forma que va a tener el gri view 
        itemCount: apiProvider.characters.length,
        controller: scrollController,
        itemBuilder: (context, index){
          final character = apiProvider.characters[index];
          return GestureDetector(
            onTap: (){
                context.go('/character');
              },
            child: Card(
              child: Column(
                children: [
                  FadeInImage(
                    placeholder: AssetImage('assets/images/portal.gif'), 
                    image: NetworkImage(character.image!)
                    ),
                  Text(character.name!, style: TextStyle( 
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                   ),)
                ],
              )
            )
          );
        } ,
      );
  }
}
