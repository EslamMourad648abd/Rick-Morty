import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled/data/models/characters.dart';
import 'package:untitled/data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  void getAllCharacters() async {
    try {
      emit(CharactersLoading()); // Optional: Show loading state
      final characters = await charactersRepository.getAllCharacters();
      emit(CharactersLoaded(characters));
    } catch (e) {
      emit(CharactersError("Failed to load characters: $e"));
    }
  }
}
