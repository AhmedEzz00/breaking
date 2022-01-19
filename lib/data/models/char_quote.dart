

class CharQuotes{
  late String quote;

  CharQuotes.fromJson(Map<String, dynamic> json){
    quote= json['quote'];
  }
}