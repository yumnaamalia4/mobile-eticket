import 'dart:convert';

import 'package:desa_wisata/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class EditTiket extends StatefulWidget {
  final String name;
  final String deskripsi;
  final String harga;
  final String image;
  const EditTiket({
    Key? key,
    required this.name,
    required this.deskripsi,
    required this.harga,
    required this.image,
  }) : super(key: key);

  @override
  _EditTiketState createState() => _EditTiketState();
}

class _EditTiketState extends State<EditTiket> {
  String uploadedFileUrl = '';
  List<String> tempatWisata = [
    "Watu Gambir",
    "Pokoh",
  ];
  List<Map<String, String>> tempatWisata1 = [
    {'4': "Watu Gambir"},
    {'5': "Pokoh"},
  ];

  Map<String, String> dropdownValue = new Map();

  String? selectedItem = 'Pilih Desa';
  // String dropDownValue;
  final TextEditingController namaWahanaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  // TextEditingController deskHargaController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? id;
  String? namaWahana;

  void initState() {
    print(widget.name.toString());
    namaWahanaController.text = widget.name;
    deskripsiController.text = widget.deskripsi;
    hargaController.text = widget.harga;
    super.initState();
    // namaWahanaController = 'Nama Wahana';
    // deskripsiController = TextEditingController(text: 'Deskripsi');
    // hargaController = TextEditingController(text: 'Harga');
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final id = arguments['id'];
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFFCC050),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Edit Wahana',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4, 4, 4, 4),
                                            child: Container(
                                              width: 120,
                                              height: 120,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.asset(
                                                'assets/image/wahana_kapal.jpg',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 160,
                                height: 40,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 24, 0, 44),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        // final selectedMedia =
                                        //     await selectMediaWithSourceBottomSheet(
                                        //   context: context,
                                        //   allowPhoto: true,
                                        // );
                                        // if (selectedMedia != null &&
                                        //     selectedMedia.every((m) =>
                                        //         validateFileFormat(
                                        //             m.storagePath,
                                        //             context))) {
                                        //   showUploadMessage(
                                        //     context,
                                        //     'Uploading file...',
                                        //     showLoading: true,
                                        //   );
                                        //   final downloadUrls = (await Future
                                        //           .wait(selectedMedia.map(
                                        //               (m) async =>
                                        //                   await uploadData(
                                        //                       m.storagePath,
                                        //                       m.bytes))))
                                        //       .where((u) => u != null)
                                        //       .toList();
                                        //   ScaffoldMessenger.of(context)
                                        //       .hideCurrentSnackBar();
                                        //   if (downloadUrls != null &&
                                        //       downloadUrls.length ==
                                        //           selectedMedia.length) {
                                        //     setState(() => uploadedFileUrl =
                                        //         downloadUrls.first);
                                        //     showUploadMessage(
                                        //       context,
                                        //       'Success!',
                                        //     );
                                        //   } else {
                                        //     showUploadMessage(
                                        //       context,
                                        //       'Failed to upload media',
                                        //     );
                                        //     return;
                                        //   }
                                        // }
                                      },
                                      style: TextButton.styleFrom(
                                          elevation: 2,
                                          backgroundColor: primaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40))),
                                      child: Text(
                                        'Upload Gambar',
                                        style: title1.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF14181B)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 70,
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                        items: tempatWisata
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.montserrat(fontSize: 18),
                                  ),
                                ))
                            .toList(),
                        onChanged: (item) {
                          setState(() {
                            selectedItem = item;
                          });
                          print(item.toString());
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: TextFormField(
                        controller: namaWahanaController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.montserrat(
                            color: Color(0xFF57636C),
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          labelText: 'Nama Wahana',
                          hintStyle: GoogleFonts.montserrat(
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDBE2E7),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDBE2E7),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                        ),
                        style: GoogleFonts.montserrat(
                          color: Color(0xFF1D2429),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: TextFormField(
                        controller: deskripsiController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.montserrat(
                            color: Color(0xFF57636C),
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          labelText: 'Deskripsi',
                          hintStyle: GoogleFonts.montserrat(
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDBE2E7),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDBE2E7),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                        ),
                        style: GoogleFonts.montserrat(
                          color: Color(0xFF1D2429),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: TextFormField(
                        controller: hargaController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.montserrat(
                            color: Color(0xFF57636C),
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          labelText: 'Harga',
                          hintStyle: GoogleFonts.montserrat(
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDBE2E7),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDBE2E7),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                        ),
                        style: GoogleFonts.montserrat(
                          color: Color(0xFF1D2429),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: TextFormField(
                        // controller: deskHargaController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.montserrat(
                            color: Color(0xFF57636C),
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          labelText: 'Deskripsi Harga',
                          hintStyle: GoogleFonts.montserrat(
                            color: Color(0xFF57636C),
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDBE2E7),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDBE2E7),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                        ),
                        style: GoogleFonts.montserrat(
                          color: Color(0xFF1D2429),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF262D34),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              child: Text(
                                'Batal',
                                style: title2.copyWith(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                print('Button pressed ...');
                                editWahana(
                                    id,
                                    namaWahanaController.text,
                                    hargaController.text,
                                    deskripsiController.text);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              child: Text(
                                'Simpan',
                                style: title2.copyWith(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final String apiUrl =
      'http://go-wisata.id/api/wahana';

  Future editWahana(id, name, harga, deskripsi) async {
    var response = await http.post(Uri.parse(apiUrl + '/update'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'id': id,
          'name': name,
          'tempat_id': "4",
          'harga': harga,
          'deskripsi': deskripsi,
        }));
    if (response.statusCode != 200) {
      const snacbar = SnackBar(
        content: Text('Gagal menambahkan wahana'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snacbar);
    } else {
      const snacbar = SnackBar(
        content: Text('Berhasil menambahkan wahana'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snacbar);
      Navigator.pop(context);
    }
    print(response.body);
    return json.decode(response.body);
  }
}
