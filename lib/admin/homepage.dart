import 'dart:convert';
import 'dart:ui';
import 'package:desa_wisata/admin/edit_tiket.dart';
import 'package:desa_wisata/main.dart';
import 'package:desa_wisata/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: background2,
        automaticallyImplyLeading: false,
        title: Text(
          'Go-Wisata',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/tambah-tiket').then((value) {
            setState(() {});
          });
        },
        backgroundColor: Color(0xFFFCC050),
        elevation: 8,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: getWahana(),
            builder: (context, AsyncSnapshot snapshot) {
              print(snapshot.connectionState);
              if (snapshot.hasData) {
                print(snapshot.data.length);
                return ListView.builder(
                    itemCount: snapshot.data.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Headerwidget();
                      } else {
                        print(snapshot.data[index - 1]);
                        return card(
                          snapshot.data[index - 1]['wahana_id'] ?? 'null',
                          snapshot.data[index - 1]['wahana_name'] ?? 'null',
                          snapshot.data[index - 1]['wahana_deskripsi'] ??
                              '-',
                          snapshot.data[index - 1]['harga'] ?? '-',
                          snapshot.data[index - 1]['wahana_image'] ?? 'null',
                        );
                        // return Text(snapshot.data[index - 1]['name']);
                      }
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

class Headerwidget extends StatelessWidget {
  const Headerwidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
          child: Stack(
            children: [
              ClipRect(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 1,
                    sigmaY: 1,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Color(0xFFFCC050),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          'assets/image/header.jpg',
                        ).image,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 50, 20, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                      child: Text(
                        'Hai, Admin ',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'Banyak Pelanggan hari ini',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      '134 Orang',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class card extends StatefulWidget {
  final int id;
  final String name;
  final String deskripsi;
  final String harga;
  final String image;
  const card(this.id, this.name, this.deskripsi, this.harga, this.image);

  @override
  State<card> createState() => _cardState();
}

class _cardState extends State<card> {
  final String baseUrl = 'http://go-wisata.id/';

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    // width: 70.0,
                    // height: 70.0,
                    // child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(20),
                    //   child: Image.network(baseUrl + 'images/' + widget.image,
                    //       width: 70, height: 70, fit: BoxFit.cover,
                    //       loadingBuilder: (BuildContext context, Widget child,
                    //           ImageChunkEvent? loadingProgress) {
                    //     if (loadingProgress == null) return child;
                    //     return Center(
                    //       child: CircularProgressIndicator(
                    //         value: loadingProgress.expectedTotalBytes != null
                    //             ? loadingProgress.cumulativeBytesLoaded /
                    //                 loadingProgress.expectedTotalBytes!
                    //             : null,
                    //       ),
                    //     );
                    //   }),
                    // ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rp. " + widget.harga,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFCC050),
                          ),
                        ),
                        Text(
                          widget.deskripsi,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  final String apiUrl =
      'http://go-wisata.id/api/wahanashow';

  Future deleteWahana(id) async {
    var response = await http.post(Uri.parse(apiUrl + '/delete'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'id': id.toString(),
        }));
    if (response.statusCode != 200) {
      const snacbar = SnackBar(
        content: Text('Gagal menghapus wahana'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snacbar);
    } else {
      const snacbar = SnackBar(
        content: Text('Berhasil menghapus wahana'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snacbar);
      // getWahana();
      var data = getWahana();
      setState(() {
        getWahana();
      });
      // ScaffoldMessenger.of(context).showSnackBar(snacbar);
      // Navigator.pop(context);

      // Navigator.pushNamed(context, '/home-admin');
    }
    print(response.body);
    return json.decode(response.body);
  }
}

class cardbackup extends StatelessWidget {
  const cardbackup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/image/wahana_kapal.jpg',
                  width: 100,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  // padding: EdgeInsetsDirectional
                  //     .fromSTEB(8, 0, 5, 0),
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kapal Kecil',
                        style: GoogleFonts.montserrat(
                          color: Color(0xFF101213),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Rp. 15.000',
                        style: GoogleFonts.montserrat(
                          color: Color(0xFFFCC050),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Wahana kapal dengan kapasitas 4 orang ',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/edit-tiket');
                                    },
                                    child: Text("Edit"),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFFFCC050)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: BorderSide(
                                                    color:
                                                        Color(0xFFFCC050)))))),
                                ElevatedButton(
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFFFF5963)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ))))
                              ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final String apiUrl =
    'http://go-wisata.id/api/wahana';

Future getWahana() async {
  var response = await http.get(Uri.parse(apiUrl));
  print(response.body);
  return json.decode(response.body);
}
