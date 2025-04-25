import 'package:dio/dio.dart';

import '../models/characters.dart';

// class CharactersRepository{
//   final CharactersAPI charactersapi;
//
//   CharactersRepository(this.charactersapi);
//
//   Future<List<Character>> getAllCharacters() async{
//     final characters = await charactersapi.getAllCharacters();
//     return characters.map((character) => Character.fromJson(character)).toList();
//   }
// }

class CharactersRepository {
  final Dio dio = Dio();

  Future<List<Character>> getAllCharacters() async {
    try {
      final response =
          await dio.get("https://rickandmortyapi.com/api/character");

      if (response.statusCode == 200) {
        final List<dynamic> results =
            response.data['results']; // ✅ Extract 'results'
        return results.map((char) => Character.fromJson(char)).toList();
      } else {
        throw Exception("Failed to load characters");
      }
    } catch (e) {
      throw Exception("Error fetching characters: $e");
    }
  }
}
