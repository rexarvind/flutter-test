class Note {
  late String id;
  late String name;
  late bool isFavorite;
  late String updatedAt;

  Note.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    isFavorite = json['is_favorite'].isEmpty ? false : true;
    updatedAt = json['updated_at'];
  }
}