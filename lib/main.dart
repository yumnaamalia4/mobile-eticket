import 'package:desa_wisata/admin/main_page_admin.dart';
import 'package:desa_wisata/admin/tambah_tiket.dart';
import 'package:desa_wisata/signinsignup.dart';
import 'package:desa_wisata/splash_page.dart';
import 'package:desa_wisata/user/checkout.dart';
import 'package:desa_wisata/user/daftar_pesanan_user.dart';
import 'package:desa_wisata/user/main_page_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
//   MidtransSDK.init(
//     config: config,
// );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': ((context) => SplashPage()),
        '/signinsignup': ((context) => SignInSignUp()),
        '/home-admin': ((context) => MainPageAdmin()),
        '/tambah-tiket': ((context) => TambahTiket()),
        '/home-user': ((context) => MainPageUser()),
        '/checkout': ((context) => CheckOut()),
        '/DaftarPesananUser': ((context) => DaftarPesananUser()),

      },
    );
  }
}

  

