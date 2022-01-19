part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactarsInitial extends CharactersState {}

class CharactersErrorCase extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;

  CharactersLoaded(this.characters);
}

class QuotesLoaded extends CharactersState {
  final List<CharQuotes> charQuotes;
  QuotesLoaded(this.charQuotes);
}
