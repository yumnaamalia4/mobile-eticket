import 'package:desa_wisata/models/tempat_model.dart';
import 'package:desa_wisata/services/tempat_services.dart';
import 'package:flutter/material.dart';

class tempatProvider with ChangeNotifier {
  List<TempatModel> _tempat = [];

  List<TempatModel> get tempat => _tempat;

  set tempat(List<TempatModel> tempat) {
    _tempat = tempat;
    notifyListeners();
  }

  Future<void> gettempat() async {
    try {
      List<TempatModel> tempat = await tempatservices().gettempat();
      _tempat = tempat;
    } catch (e) {
      print(e);
    }
  }
}
