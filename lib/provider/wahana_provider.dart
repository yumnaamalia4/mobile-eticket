import 'package:desa_wisata/models/wahana_model.dart';
import 'package:desa_wisata/services/wahana_services.dart';
import 'package:flutter/material.dart';

class WahanaProvider with ChangeNotifier {
  List<WahanaModel> _wahana = [];

  List<WahanaModel> get wahana => _wahana;

  set wahana(List<WahanaModel> wahana) {
    _wahana = wahana;
    notifyListeners();
  }

  Future<void> getwahana() async {
    try {
      List<WahanaModel> wahana = await wahanaservices().getwahana();
      _wahana = wahana;
    } catch (e) {
      print(e);
    }
  }
}
