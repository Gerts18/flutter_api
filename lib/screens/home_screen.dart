import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/provider/api_provider.dart';
import 'package:rick_and_morty_app/widgets/search_delegate.dart';

// Pantalla principal de la aplicación donde se mostrara una lista de todos los personajes de la serie Rick and Morty.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollControler = ScrollController();
  bool isLoading = false;
  int page = 1;

  @override /*Esto lo ponemos para que en cuanto se dibuje el widget se pueda llamar a la Api */
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getCharacters(page); //Obtenemos los personajes
    scrollControler.addListener(() async {
      if (scrollControler.position.pixels ==
          scrollControler.position.maxScrollExtent) {
        //Si ya estamos en el final de la pagina
        setState(() {
          isLoading = true;
        });
        page++;
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
        actions: [
          IconButton(
            onPressed: (){
              showSearch(context: context, delegate: SearchCharacter());
            }
          , icon: Icon(Icons.search)
          )
        ],
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
  const CharacterList({
    super.key,
    required this.apiProvider,
    required this.scrollController,
    required this.isLoading,
  });

  final ApiProvider apiProvider;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    // Cálculo dinámico de columnas basado en el ancho de la pantalla
    final deviceWidth = MediaQuery.of(context).size.width;
    // Calcula y limita el crossAxisCount a un mínimo de 2 y máximo de 4
    int crossAxisCount = (deviceWidth / 200).floor();
    if (crossAxisCount < 2) crossAxisCount = 2;
    if (crossAxisCount > 4) crossAxisCount = 4;
    
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ), //La forma que va a tener el gri view
      itemCount:
          isLoading
              ? apiProvider.characters.length + 2
              : apiProvider.characters.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < apiProvider.characters.length) {

          final character = apiProvider.characters[index];
          return GestureDetector(
            onTap: () {
              context.go('/character', extra: character);
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Hero(
                      tag: character.id!,
                      child: FadeInImage(
                        placeholder: AssetImage('assets/images/portal.gif'),
                        image: NetworkImage(character.image!),
                        fit: BoxFit.contain,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      character.name!,
                      style: TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );

        }else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
