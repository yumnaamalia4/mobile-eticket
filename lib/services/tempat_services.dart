import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:desa_wisata/models/tempat_model.dart';

class tempatservices {
  String baseUrl = 'http://go-wisata.id/api';

  Future<List<TempatModel>> gettempat() async {
    var url = '$baseUrl/tempat';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<TempatModel> tempat = [];

      for (var item in data) {
        tempat.add(TempatModel.fromJson(item));
      }

      return tempat;
    } else {
      throw Exception('Gagal Get tempat!');
    }
  }

}
