import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/char_quote.dart';
import '../../data/models/charachers.dart';
import '../../data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];
  
  CharactersCubit(this.charactersRepository) : super(CharactarsInitial());
  
  List<Character> getAllCharacters() {
    charactersRepository.gettAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getAllQuotes(String authorName) {
    charactersRepository.gettAllQuotes(authorName).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }
}
