import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:rick_and_morty_app/provider/api_provider.dart';

import 'package:rick_and_morty_app/screens/character_screen.dart';
import 'package:rick_and_morty_app/screens/home_screen.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [ /* Sub rutas que dependeran de la ruta principal  */
        GoRoute(
          path: '/character',
          builder: (context, state){
            final character = state.extra as Character;
            return CharacterScreen(
              character: character,
            );
          }
          )
      ],
    ),
  ],
); /* Creamos el enrutador de la app  */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      child: MaterialApp.router(
        title: 'Rick and Morty App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
        routerConfig: _router, /* Le decimos que queremos usar nuestra configuración de routing para manejar las pantallas de la app */
      ),
    );
  }
} 
