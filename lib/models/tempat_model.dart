

class TempatModel {
  late final int id;
  late final String kategori;
  late final String name;
  late final String deskripsi;
  late final String alamat;
  late final String email;
  late final String telp;
  late final String image;
  late final int status;
  late final int htm;
  late final String slug;
  late final DateTime createdAt;
  late final DateTime updatedAt;

  TempatModel({
    required id,
    required kategori,
    required name,
    required deskripsi,
    required alamat,
    required email,
    required telp,
    required image,
    required status,
    required htm,
    required slug,
    required createdAt,
    required updatedAt,
  });

  TempatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    htm = double.parse(json['htm'].toString()) as int;
    deskripsi = json['deskripsi'];
    alamat = json['alamat'];
    email = json['email'];
    telp = json['telp'];
    image = json['image'];
    status = json['status'];
    kategori = json['kategori'];
    slug = json['slug'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'htm': htm,
      'deskripsi': deskripsi,
      'alamat': alamat,
      'email': email,
      'telp': telp,
      'image': image,
      'status': status,
      'kategori': kategori,
      'slug': slug,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}