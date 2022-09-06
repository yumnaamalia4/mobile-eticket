class UserModel {
  late final int id;
  late final String name;
  late final String email;
  late final String username;
  late final String image;
  late final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.image,
    required this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'image': image,
      'token': token,
    };
  }
}
