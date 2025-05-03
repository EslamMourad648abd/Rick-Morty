import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/business_logic/cubit/characters_cubit.dart';
import 'package:untitled/constants/strings.dart';
import 'package:untitled/data/repository/characters_repository.dart';
import 'package:untitled/preseentation/screens/characters_details.dart';
import 'package:untitled/preseentation/screens/characters_screen.dart';

import 'data/models/characters.dart';

class AppRouter {
  late final CharactersRepository charactersRepository;
  late final CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository();
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: charactersCubit,
            child: CharactersScreen(),
          ),
        );

      case charactersDetailsSceen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(
                  character: character,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text("Error")),
            body: Center(child: Text("Page Not Found")),
          ),
        );
    }
  }
}
