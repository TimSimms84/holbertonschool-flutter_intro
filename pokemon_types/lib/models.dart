class Character {
  String name;
  String imgUrl;
  int id;

  Character({required this.name, required this.imgUrl, required this.id});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      imgUrl: json['image'],
      id: json['id'],
    );
  }
}
