import 'package:desa_wisata/data.dart';
import 'package:desa_wisata/theme.dart';
import 'package:desa_wisata/user/tiket.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DaftarPesananUser extends StatefulWidget {
  const DaftarPesananUser({Key? key}) : super(key: key);

  @override
  _DaftarPesananUserState createState() => _DaftarPesananUserState();
}

class _DaftarPesananUserState extends State<DaftarPesananUser> {
  String token = "kosong";
  bool isLoadid = true;
  String id = '';
  @override
  void initState() {
    setState(() {});
    // TODO: implement initState
    gettoken().then((value) {
      token = value;
    });
    getid().then((value) {
      setState(() {
        id = value;
        isLoadid = false;
      });
    });

    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: background2,
        automaticallyImplyLeading: false,
        title: Text(
          'Riwayat Pembelian',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  labelColor: Color(0xFF090F13),
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  indicatorColor: primaryColor,
                  tabs: [
                    Tab(
                      text: 'Tiket',
                    ),
                    Tab(
                      text: 'Daftar Transaksi',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      FutureBuilder(
                          future: getPesanan(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.data == null) {
                              return Center(
                                child: Text('Tiket Kosong'),
                              );
                            } else if (snapshot.hasData) {
                              // print(snapshot.data);
                              return RefreshIndicator(
                                onRefresh: () { 
                                  setState(() {
                                    getPesanan();
                                  });
                                  return getPesanan();
                                 },
                                child: ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Tiket(
                                                    kode: snapshot.data[index]
                                                        ['kode'],
                                                    status: snapshot.data[index]
                                                        ['status']),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Color(0xFFF1F4F8),
                                                width: 2,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                      16, 8, 16, 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        //TODO change to snapshot data
                                                        snapshot.data[index][
                                                                    'created_at'] !=
                                                                null
                                                            ? snapshot.data[index]
                                                                    ['created_at']
                                                                .substring(0, 10)
                                                            : 'null',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          color:
                                                              Color(0xFF7C8791),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 4, 0, 0),
                                                                    
                                                        child: snapshot.data[index]
                                                                  ['status'] == 1 ?
                                                        Text('Sudah Bayar',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            color:
                                                                Color(0xFF090F13),
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        )
                                                        :Text('Belum Bayar',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            color:
                                                                Color(0xFF090F13),
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        )
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons.chevron_right_rounded,
                                                    color: Color(0xFF95A1AC),
                                                    size: 24,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                    }),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                      FutureBuilder(
                          future: getTransaksi(),
                          builder: (context, AsyncSnapshot snapshot) {
                            // print(snapshot.connectionState.toString());
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.data == null) {
                              return Center(
                                child: Text('Tiket Kosong'),
                              );
                            } else if (snapshot.hasData) {
                              // ListView.builder(itemBuilder:
                              // )
                              return ListView.builder(
                                  itemCount: snapshot.data.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return titlewidget();
                                    } else {
                                      return isidaftar(
                                          name: snapshot.data[index - 1]
                                                  ['name'] ??
                                              'null',
                                          date: snapshot.data[index - 1]
                                                  ['created_at'].substring(0, 10) ??
                                              'null',
                                          price: NumberFormat.decimalPattern()
                                              .format(snapshot.data[index - 1]
                                                      ['harga'] ??
                                                  'null'));
                                    }
                                  });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// TODO change backend API
  final String baseUrl = 'http://go-wisata.id/';
  final String apiUrl = 'http://go-wisata.id/api/';

  getid() async {
    final sf = await SharedPreferences.getInstance();
    String token = sf.getString('id').toString();
    return token;
  }

  gettoken() async {
    final sf = await SharedPreferences.getInstance();
    String token = sf.getString('token').toString();
    return token;
  }

  Future getPesanan() async {
    final Data datas = dataList[dataList.length - 1];
    String token = datas.id;
    print(token);
    http.Response response = await http.post(
      Uri.parse("${apiUrl}tiket?id=$token"),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': token,
      }),
    );
    if (response.statusCode != 200) {
      return null;
    } else {
      return json.decode(response.body);
    }
  }

  Future getTransaksi() async {
    final Data datas = dataList[dataList.length - 1];
    String token = datas.id;
    http.Response response = await http.get(
      Uri.parse(apiUrl + "daftartransaksi?id=" + token),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode != 200) {
      return null;
    } else {
      return json.decode(response.body);
    }
  }
}

class isidaftar extends StatelessWidget {
  final String name;
  final String date;
  final String price;
  const isidaftar(
      {Key? key, required this.name, required this.date, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: background3,
          boxShadow: [
            BoxShadow(
              color: Color(0xff22282F),
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    // 'Tiket Masuk Watu Gambir',
                    style: subtitle1.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      date,
                      // 'Feb 15, 2022',
                      style: bodyText2,
                    ),
                  ),
                ],
              ),
              Column(
              children: [
                Text(
                  "Rp " + price,
                  // 'Rp. 15.000',
                  style: bodyText2,
                ),
              ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class titlewidget extends StatelessWidget {
  const titlewidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
            child: Text(
              'Purchase History',
              style: bodyText2,
            ),
          ),
        ]);
  }
}
