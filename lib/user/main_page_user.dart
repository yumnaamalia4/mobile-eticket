import 'package:desa_wisata/theme.dart';
import 'package:desa_wisata/user/akun_user.dart';
import 'package:desa_wisata/user/daftar_pesanan_user.dart';
import 'package:desa_wisata/user/homepage_user.dart';
import 'package:flutter/material.dart';


class MainPageUser extends StatefulWidget {
  const MainPageUser({Key? key}) : super(key: key);

  @override
  State<MainPageUser> createState() => _MainPageUserState();
}

class _MainPageUserState extends State<MainPageUser> {
  int currentIndex = 0;

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
              Icons.list_alt,
              size: 40,
            ),
            label: 'Daftar Pesanan',
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
          return HomePageUser();
          break;
        case 1:
          return DaftarPesananUser();
          break;
        case 2:
          return AkunUser();
          break;

        default:
          return HomePageUser();
      }
    }

    return Scaffold(
      backgroundColor: background3,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
