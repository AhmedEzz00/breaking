class Character {
  int? char_id;
  String? name;
  String? birthday;
  String? nickname;
  String? img;
  String? status;
  String? category;
  String? portrayed;
  List<dynamic>? occupation;
  List<dynamic>? appearance; //breaking bad appearance
  List<dynamic>? better_call_saul_appearance;

  Character.fromJson(Map<String, dynamic> json) {
    char_id = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    nickname = json['nickname'];
    img = json['img'];
    status = json['status'];
    category = json['category'];
    portrayed = json['portrayed'];
    occupation = json['occupation'];
    appearance = json['appearance'];
    better_call_saul_appearance = json['better_call_saul_appearance'];
  }
}
