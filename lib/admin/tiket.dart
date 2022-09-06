import 'dart:collection';
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:desa_wisata/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Tiket extends StatefulWidget {
  final String tiket;
  const Tiket({Key? key, required this.tiket}) : super(key: key);

  @override
  _TiketState createState() => _TiketState();
}

class _TiketState extends State<Tiket> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = true;
  var found = false;

  List data = List.filled(0, null);

  int length = 0;

  @override
  void initState() {
    // TODO: implement initState
    getTiket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          'Tiket Admin',
          style: title3.copyWith(
            color: Colors.white,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: !found
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.tiket),
                            Text('Tiket tidak ditemukan'),
                          ],
                        ))
                      : tiketWidget(widget: this.widget, data: this.data)
                  // list()
                  ),
              // tiketWidget(widget: widget),
            ),
    );
  }

  final String apiUrl =
      'http://go-wisata.id/api/tiket/detail';

  Future getTiket() async {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': '11',
        'kode': widget.tiket,
      }),
    );
    if (response.statusCode != 200) {
      setState(() {
        this.isLoading = false;
      });
      return null;
    } else {
      final data = json.decode(response.body);
      setState(() {
        this.found = true;
        this.isLoading = false;
        this.data = data
            .map<HashMap<String, dynamic>>(
                (e) => HashMap<String, dynamic>.from(e))
            .toList();
        this.length = response.body.length;
        print('data' + response.body.length.toString());
      });
      print(response.body[0]);
      return json.decode(response.body);
    }
  }
}

list(List data) {
  var jumlah;
  return Column(
    children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tgl Pembelian',
            style: GoogleFonts.getFont(
              'Montserrat',
              fontSize: 14,
            ),
          ),
          Text(
            data[0]['tanggal_a'] != null
                ? data[0]['tanggal_a'].substring(0, 10)
                : 'null',
            // '21/06/2022',
            style: bodyText1,
          ),
        ],
      ),
      Column(
          children: data
              .map((item) => Row(
                    children: [
                      data.indexOf(item) == 0
                          ? Text(
                              'Detail Pembelian',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontSize: 14,
                              ),
                            )
                          : Text(
                              " ",
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontSize: 14,
                              ),
                            ),
                      Expanded(
                        child: Text(
                          item['name'].toString() +
                              item['jumlah'].toString() +
                              " x " +
                              item['harga'].toString(),
                          style: bodyText1,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ))
              .toList()),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: GoogleFonts.getFont(
                'Montserrat',
                fontSize: 14,
              ),
            ),
            Text(
              'Rp. ' + getTotal(data).toString(),
              style: bodyText1,
            ),
            // Text('Rp. 20.000', style: bodyText1),
          ],
        ),
      )
    ],
  );
}

getTotal(List data) {
  int total = 0;
  for (var i = 0; i < data.length; i++) {
    int harga = data[i]['harga'] ?? 0;
    int jumlah = int.parse(data[i]['jumlah']);
    total += harga * jumlah;
  }
  return total;
}

class tiketWidget extends StatelessWidget {
  const tiketWidget({
    Key? key,
    required this.widget,
    required this.data,
  }) : super(key: key);

  final Tiket widget;
  final List data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(35, 35, 35, 0),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                ),
                child: QrImage(
                  data: widget.tiket,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(35, 0, 35, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.tiket,
                  style: bodyText1,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 35, 25, 35),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ID Order',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        widget.tiket,
                        // '20220621345678901',
                        style: bodyText1,
                      ),
                    ],
                  ),
                ),
                list(data),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
