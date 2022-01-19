import '../models/char_quote.dart';
import '../models/charachers.dart';
import '../web%20services/web_services.dart';
import 'package:flutter/cupertino.dart';

class CharactersRepository {
  
  final CharactersWebServices charactersWebServices;
  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> gettAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<CharQuotes>> gettAllQuotes(String authorName) async {
    final quotes = await charactersWebServices.getAllQuotes(authorName);
    return quotes.map((quote) => CharQuotes.fromJson(quote)).toList();
  }
}
