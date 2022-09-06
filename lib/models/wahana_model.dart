import 'package:desa_wisata/models/tempat_model.dart';

class WahanaModel {
  late final int id;
  late final TempatModel tempat_id;
  late final String name;
  late final String deskripsi;
  late final String image;
  late final int status;
  late final int harga;
  late final String deskripsi_harga;
  late final DateTime createdAt;
  late final DateTime updatedAt;

  WahanaModel({
    required id,
    required tempat_id,
    required name,
    required deskripsi,
    required image,
    required status,
    required harga,
    required deskripsi_harga,
    required createdAt,
    required updatedAt,
  });

  WahanaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    harga = double.parse(json['harga'].toString()) as int;
    tempat_id = TempatModel.fromJson(json['tempat_id']);
    deskripsi = json['deskripsi'];
    image = json['image'];
    status = json['status'];
    deskripsi_harga = json['deskripsi_harga'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'harga': harga,
      'tempat_id': tempat_id.toJson(),
      'deskripsi': deskripsi,
      'image': image,
      'status': status,
      'deskripsi_harga': deskripsi_harga,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}

