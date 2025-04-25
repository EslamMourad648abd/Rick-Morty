part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {} // ✅ Added loading state

class CharactersLoaded extends CharactersState {
  // ✅ Fixed the typo
  final List<Character> characters;
  CharactersLoaded(this.characters);
}

class CharactersError extends CharactersState {
  // ✅ Added error handling
  final String message;
  CharactersError(this.message);
}
