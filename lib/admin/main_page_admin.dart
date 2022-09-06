import 'package:desa_wisata/admin/akun_admin.dart';
import 'package:desa_wisata/admin/homepage.dart';
import 'package:desa_wisata/admin/backupscan_tiket_admin.dart';
import 'package:desa_wisata/admin/konfirmBayar.dart';
import 'package:desa_wisata/admin/scan_tiket_admin.dart';
import 'package:desa_wisata/data.dart';
import 'package:desa_wisata/theme.dart';
import 'package:flutter/material.dart';

class MainPageAdmin extends StatefulWidget {
  const MainPageAdmin({Key? key}) : super(key: key);

  @override
  State<MainPageAdmin> createState() => _MainPageAdminState();
}

class _MainPageAdminState extends State<MainPageAdmin> {
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget customBottomNav() {
      return BottomNavigationBar(
        backgroundColor: Color(0xFFFFFFFF),
        currentIndex: currentIndex,
        onTap: (value) {
          print(value);
          setState(() {
            currentIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              size: 40,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner_rounded,
              size: 40,
            ),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              size: 40,
            ),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_rounded,
              size: 40,
            ),
            label: 'Akun',
          )
        ],
        selectedItemColor: primaryColor,
        unselectedItemColor: Color(0xF8A000000),
      );
    }

    Widget body() {
      switch (currentIndex) {
        case 0:
          return HomePage();
          break;
        case 1:
          return ScanTiket();
          break;
        case 2:
          return KonfirmBayar();
          break;
        case 3:
          return AkunAdmin();
          break;

        default:
          return HomePage();
      }
    }

    return Scaffold(
      backgroundColor: background3,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
