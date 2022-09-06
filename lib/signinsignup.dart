import 'package:desa_wisata/data.dart';
import 'package:desa_wisata/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SignInSignUp extends StatefulWidget {
  const SignInSignUp({Key? key}) : super(key: key);

  @override
  _SignInSignUpState createState() => _SignInSignUpState();
}

var isLoading = false;

class _SignInSignUpState extends State<SignInSignUp> {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailSignUpController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordSignUpController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  // final _formregKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formregKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFFCC050),
        body: Center(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 100.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Go-Wisata',
                                    style: GoogleFonts.fugazOne(
                                      fontSize: 50,
                                      color: textColor1,
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: DefaultTabController(
                                  length: 2,
                                  initialIndex: 0,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        isScrollable: true,
                                        labelColor: Color(0xFFFFFFFF),
                                        labelPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                24, 0, 24, 0),
                                        labelStyle: GoogleFonts.montserrat(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        indicatorColor: Color(0xFFFFFFFF),
                                        tabs: [
                                          Tab(
                                            text: 'Sign In',
                                          ),
                                          Tab(
                                            text: 'Sign Up',
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(24, 24, 24, 24),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20, 20, 20, 0),
                                                    child: TextFormField(
                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                      validator: (value) => validateEmail(value),
                                                      controller:emailAddressController,
                                                      // obscureText: false,
                                                      decoration:InputDecoration(
                                                        labelText:'Email Address',
                                                        labelStyle: GoogleFonts.montserrat(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        hintStyle: GoogleFonts
                                                            .montserrat(
                                                          color:
                                                              Color(0x98FFFFFF),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                        enabledBorder:OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        contentPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(20,
                                                                    16, 20, 16),
                                                      ),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xFF0F1113),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                                                    child: TextFormField(
                                                      controller:
                                                          passwordController,
                                                      obscureText: true,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Password',
                                                        labelStyle: GoogleFonts.montserrat(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                        hintStyle: GoogleFonts.montserrat(
                                                          color:Color(0x98FFFFFF),
                                                          fontSize: 14,
                                                          fontWeight:FontWeight.normal,
                                                        ),
                                                        enabledBorder:OutlineInputBorder(
                                                          borderSide:BorderSide(
                                                            color: Colors.white,
                                                            width: 1,
                                                          ),
                                                          borderRadius:BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        contentPadding:EdgeInsetsDirectional
                                                                .fromSTEB(20, 16, 20, 16),
                                                      ),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xFF0F1113),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    width: 230,
                                                    margin: EdgeInsets.only(top: 35),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        if (isLoading) {
                                                        } else {
                                                          login();
                                                          setState(() {
                                                          isLoading = true;
                                                          });
                                                        }
                                                      },
                                                      style: TextButton.styleFrom(
                                                          backgroundColor:
                                                              textColor1,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8))),
                                                      child: isLoading
                                                          ? Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : Text(
                                                              'Sign In',
                                                              style: title2
                                                                  .copyWith(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(24, 24, 24, 0),
                                              child: Form(
                                                key: _formregKey,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:EdgeInsetsDirectional.fromSTEB( 20, 20, 20, 0),
                                                      child: TextFormField(
                                                        controller:
                                                            usernameController,
                                                        obscureText: false,
                                                        decoration: InputDecoration(
                                                          labelText: 'User Name',
                                                          labelStyle: GoogleFonts.montserrat(
                                                            color: secondaryText1,
                                                          ),
                                                          hintText: 'Masukan Nama Anda',
                                                          hintStyle: GoogleFonts.montserrat(
                                                            color: Color(0x98FFFFFF),
                                                            fontSize: 14,
                                                            fontWeight:FontWeight.normal,
                                                          ),
                                                          enabledBorder:OutlineInputBorder(
                                                            borderSide:BorderSide(
                                                              color: Colors.white,
                                                              width: 1,
                                                            ),
                                                            borderRadius:BorderRadius.circular(8),
                                                          ),
                                                          focusedBorder:OutlineInputBorder(
                                                            borderSide:BorderSide(
                                                              color: Colors.white,
                                                              width: 1,
                                                            ),
                                                            borderRadius:BorderRadius
                                                                    .circular(8),
                                                          ),
                                                          filled: true,
                                                          fillColor: Colors.white,
                                                          contentPadding: EdgeInsetsDirectional.fromSTEB(20,16, 20, 16),
                                                        ),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          color:
                                                              Color(0xFF0F1113),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  20, 20, 20, 0),
                                                      child: TextFormField(
                                                        controller:
                                                            phoneNumberController,
                                                        obscureText: false,
                                                        decoration:InputDecoration(
                                                          labelText: 'No. HP',
                                                          labelStyle: GoogleFonts.montserrat(
                                                            color: secondaryText1,
                                                          ),
                                                          hintText:'Masukan No. HP',
                                                          hintStyle: GoogleFonts.montserrat(
                                                            color:Color(0x98FFFFFF),
                                                            fontSize: 14,
                                                            fontWeight:FontWeight.normal,
                                                          ),
                                                          enabledBorder:OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Colors.white,
                                                              width: 1,
                                                            ),
                                                            borderRadius:BorderRadius.circular(8),
                                                          ),
                                                          focusedBorder:OutlineInputBorder(
                                                            borderSide:BorderSide(
                                                              color: Colors.white,
                                                              width: 1,
                                                            ),
                                                            borderRadius:BorderRadius.circular(8),
                                                          ),
                                                          filled: true,
                                                          fillColor: Colors.white,
                                                          contentPadding:EdgeInsetsDirectional.fromSTEB(20,16, 20, 16),
                                                        ),
                                                        style: GoogleFonts.montserrat(
                                                          color:Color(0xFF0F1113),
                                                        ),
                                                        keyboardType:TextInputType.phone,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                                                      child: TextFormField(
                                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                                        validator: (value) => validateEmail(value),
                                                        controller:emailSignUpController,
                                                        obscureText: false,
                                                        decoration: InputDecoration(
                                                          labelText:'Email Address',
                                                          labelStyle: GoogleFonts.montserrat(
                                                            color: secondaryText1,
                                                          ),
                                                          hintText:'Enter your email...',
                                                          hintStyle: GoogleFonts.montserrat(
                                                            color: Color(0x98FFFFFF),
                                                            fontSize: 14,
                                                            fontWeight:FontWeight.normal,
                                                          ),
                                                          enabledBorder:OutlineInputBorder(
                                                            borderSide:BorderSide(
                                                              color: Colors.white,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                          ),
                                                          focusedBorder:OutlineInputBorder(
                                                            borderSide:BorderSide(
                                                              color: Colors.white,
                                                              width: 1,
                                                            ),
                                                            borderRadius:BorderRadius.circular(8),
                                                          ),
                                                          filled: true,
                                                          fillColor: Colors.white,
                                                          contentPadding:EdgeInsetsDirectional.fromSTEB(20,16, 20, 16),
                                                        ),
                                                        style: GoogleFonts.montserrat(
                                                          color:Color(0xFF0F1113),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                                                      child: TextFormField(
                                                        obscureText: true,
                                                        controller:
                                                            passwordSignUpController,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Password',
                                                          labelStyle: GoogleFonts
                                                              .montserrat(
                                                            color: secondaryText1,
                                                          ),
                                                          hintText:'Enter your password...',
                                                          hintStyle: GoogleFonts.montserrat(
                                                            color:Color(0x98FFFFFF),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.normal,
                                                          ),
                                                          enabledBorder:OutlineInputBorder(
                                                            borderSide:BorderSide(
                                                              color: Colors.white,
                                                              width: 1,
                                                            ),
                                                            borderRadius:BorderRadius
                                                                    .circular(8),
                                                          ),
                                                          focusedBorder:OutlineInputBorder(
                                                            borderSide:BorderSide(
                                                              color: Colors.white,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                          ),
                                                          filled: true,
                                                          fillColor: Colors.white,
                                                          contentPadding:EdgeInsetsDirectional
                                                                  .fromSTEB(20,
                                                                      16, 20, 16),
                                                        ),
                                                        style: GoogleFonts .montserrat(
                                                          color:Color(0xFF0F1113),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      width: 230,
                                                      margin: EdgeInsets.only(
                                                          top: 35),
                                                      child: isLoading
                                                          ? Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : TextButton(
                                                              onPressed: () {
                                                                if (emailValidation(emailSignUpController.text)) {
                                                                  register();
                                                                  setState(() {
                                                                  isLoading =
                                                                      true;
                                                                  });
                                                                }
                                                                else{
                                                                  const snackBar = SnackBar(
                                                                    content: Text('format email salah!'),
                                                                    backgroundColor: Colors.red,
                                                                  );
                                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                }
                                                              },
                                                              style: TextButton.styleFrom(
                                                                  backgroundColor:textColor1,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(
                                                                              8))),
                                                              child: Text('Sign Up',
                                                                style: title2.copyWith(
                                                                  fontSize: 18,
                                                                  fontWeight:FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  redirect(String res) {
    // print('res' + res.toString());
    if (isLoading && res == "2") {
      Navigator.pushNamedAndRemoveUntil(context, '/home-admin', (route) => false);
      setState(() {
        isLoading = false;
      });
    } else if (isLoading && res == "5") {
      Navigator.pushNamedAndRemoveUntil(
          context, '/home-user', (route) => false);
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      const snackBar = SnackBar(
        content: Text('Username/password salah'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response = await http.post(
      Uri.parse("http://go-wisata.id/api/login"),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': emailAddressController.text,
        'password': passwordController.text,
      }),
    );
    var data = json.decode(response.body);
    if (response.statusCode != 200) {
      // return null;
      print(((data as Map)['data']));
      redirect(response.statusCode.toString());
    } else {
      Data datas = Data(
        id: ((data as Map)['data']['id']).toString(),
        name: (data)['data']['name'],
        email: (data)['data']['email'],
        telp: (data)['data']['telp'],
        role_id: ((data)['data']['role_id']).toString(),
      );
      dataList.add(datas);
      //session

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", true);
      prefs.setString("loginRole", (data)['data']['role_id'].toString());
      prefs.setString("loginId", (data)['data']['id'].toString());
      prefs.setString("loginName", (data)['data']['name']);
      prefs.setString("loginEmail", (data)['data']['email']);
      prefs.setString("loginTelp", (data)['data']['telp']);
    }
    redirect(((data)['data']['role_id']).toString());

    return data;
    // return json.decode(response.body);
  }

  Future register() async {
    http.Response response = await http.post(
      Uri.parse("http://go-wisata.id/api/register"),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': usernameController.text,
        'email': emailSignUpController.text,
        'password': passwordSignUpController.text,
        'telp': phoneNumberController.text,
      }),
    );
    var data = json.decode(response.body);
    // print(usernameController.text +
    //     emailSignUpController.text +
    //     passwordController.text +
    //     phoneNumberController.text);
    // print(response.body.toString());
    if (response.statusCode != 200) {
      const snackBar = SnackBar(
        content: Text('Gagal registrasi'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
      });
    } else {
      //session
      Data datas = Data(
        id: ((data as Map)['data']['id']).toString(),
        name: (data)['data']['name'],
        email: (data)['data']['email'],
        telp: (data)['data']['telp'],
        role_id: ((data)['data']['role_id']).toString(),
      );
      dataList.add(datas);
      //session

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", true);
      prefs.setString("loginRole", ((data)['data']['role_id']).toString());
      prefs.setString("loginId", ((data)['data']['id']).toString());
      prefs.setString("loginName", (data)['data']['name']);
      prefs.setString("loginEmail", (data)['data']['email']);
      prefs.setString("loginTelp", (data)['data']['telp']);

      const snackBar = SnackBar(
        content: Text('Registrasi Berhasil'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, '/home-user');
    }
    return data;
  }

  String validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return "";
  }

  emailValidation(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}
