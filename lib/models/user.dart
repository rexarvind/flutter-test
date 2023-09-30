class User {
  String? id;
  String? name;
  String? username;
  String? email;
  User({this.id, this.name, this.email, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'].toString(),
      username: json['username'].toString(),
      email: json['email'].toString(),
    );
  }
}
