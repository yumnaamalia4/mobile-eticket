import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:desa_wisata/models/wahana_model.dart';

class wahanaservices {
  String baseUrl = 'http://go-wisata.id/api';

  Future<List<WahanaModel>> getwahana() async {
    var url = '$baseUrl/wahana';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<WahanaModel> wahana = [];

      for (var item in data) {
        wahana.add(WahanaModel.fromJson(item));
      }

      return wahana;
    } else {
      throw Exception('Gagal Get wahana!');
    }
  }

  Future<List<WahanaModel>> gettempat() async {
    var url = '$baseUrl/tempat';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<WahanaModel> wahana = [];

      for (var item in data) {
        wahana.add(WahanaModel.fromJson(item));
      }

      return wahana;
    } else {
      throw Exception('Gagal Get tempat!');
    }
  }
}
