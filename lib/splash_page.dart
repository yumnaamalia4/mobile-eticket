import 'dart:async';

import 'package:desa_wisata/data.dart';
import 'package:desa_wisata/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  void navigateUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = prefs.getBool('isLoggedIn') ?? false;
    String loginRole = prefs.getString('loginRole') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    String loginName = prefs.getString('loginName') ?? '';
    String loginEmail = prefs.getString('loginEmail') ?? '';
    String loginTelp = prefs.getString('loginTelp') ?? '';

    Data datas = Data(
      id: loginId,
      name: loginName,
      email: loginEmail,
      telp: loginTelp,
      role_id: loginRole,
    );
    dataList.add(datas);

    redirect(loginRole, status);
  }

  void redirect(String loginRole, bool status){
    // print("from splash $status");
    if (status) {
      if (loginRole == "2") {
        Navigator.pushNamedAndRemoveUntil(context, '/home-user', (route) => false);
      }
      else{
        Navigator.pushNamedAndRemoveUntil(context, '/home-user', (route) => false);
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(context, "/signinsignup", (route) => false);
    }
  }

  @override
  initState(){
    Timer(Duration(seconds: 5),
      () => navigateUser());
      //() => Navigator.pushNamedAndRemoveUntil(context, "/signinsignup", (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFCC050),
        body: Center(
            child: Text(
          'Go-Wisata',
          style: GoogleFonts.fugazOne(
            fontSize: 50,
            color: textColor1,
          ),
        )));
  }
}


