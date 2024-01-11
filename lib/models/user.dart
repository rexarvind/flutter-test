class User {
  String? id;
  String? name;
  String? username;
  String? email;
  User({this.id, this.name, this.email, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'].toString(),
      name: json['user']['name'].toString(),
      username: json['user']['username'].toString(),
      email: json['user']['email'].toString(),
    );
  }
}
