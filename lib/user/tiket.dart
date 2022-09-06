import 'dart:collection';
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:desa_wisata/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:desa_wisata/user/payScreenweb.dart';

class Tiket extends StatefulWidget {
  final String kode;
  final int status;
  const Tiket({Key? key, required this.kode, required this.status})
      : super(key: key);

  @override
  _TiketState createState() => _TiketState();
}

class _TiketState extends State<Tiket> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = true;
  var found = false;
  // var paymentStatus = false;

  List data = List.filled(0, null);

  int length = 0;

  @override
  void initState() {
    // TODO: implement initState
    // getTiket();
    checkPayment(widget.kode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(this.widget.status);
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
          'Ticket',
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
                            Text(widget.kode),
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
        'kode': widget.kode,
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
      });
      return json.decode(response.body);
    }
  }

  Future checkPayment(String kode) async{
    print('checking payment');
    var url= 'http://go-wisata.id/api/pay/finish?id=$kode';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      }
    );
    // if (response.statusCode == 500) {
      print(response.body);
    //   throw Exception('http.post error: statusCode= ${response.statusCode}');
    // }
    // else{
    //   getTiket();
    // }
    setState(() {
      getTiket();
    });
    
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
            'Purchase date',
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
                              'Purchase Details',
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
                              " (" +
                              item['jumlah'].toString() +
                              ") = " +
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
              'Rp. ${getTotal(data)}',
              style: bodyText1,
            ),
            // Text('Rp. 20.000', style: bodyText1),
          ],
        ),
      )
    ],
  );
}

itemOnly(List data) {
  return Column(
      children: data
          .map((item) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${item['name']} (${item['jumlah']})",
                    style: bodyText1,
                    textAlign: TextAlign.end,
                  ),
                ],
              ))
          .toList());
}

getTotal(List data) {
  int total = 0;
  for (var i = 0; i < data.length; i++) {
    int harga = data[i]['harga'] ?? 0;
    // int jumlah = int.parse(data[i]['jumlah']);
    // total += harga * jumlah;
    total += harga ;
  }
  return total;
}

Future<String> getPaymentLink(String kodeTransaksi, int total, List data) async {
  // print("total $total");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String loginName = prefs.getString('loginName') ?? '';
  String loginEmail = prefs.getString('loginEmail') ?? '';
  String loginTelp = prefs.getString('loginTelp') ?? '';

  var user = {
    'name':loginName,
    'email':loginEmail,
    'telp': loginTelp,
  };
  var customerDetails = jsonEncode(user);

  var product={
    "id": "tix-001", 
    "nama": data[0]['name'],
    "harga":data[0]['harga'],     
    "qty": 1 
  };
  var productDetails = jsonEncode(product);
  
  var response = await http.post(Uri.parse("http://go-wisata.id/api/pay/payment"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'dataproduk': productDetails,
        'datauser': customerDetails,
        'total': total.toString(),
        'kodeTransaksi': kodeTransaksi,
      }),
      );

  if (response.statusCode != 200){
      // print(response.body);
      throw Exception('http.post error: statusCode= ${response.statusCode}');
  } 
  else{
    Map<String, dynamic> msg = json.decode(response.body);
    var paymentlink = msg['data'];
    return paymentlink;
  }
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
    return widget.status == 0
    // return widget.found
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('transaction code ${widget.kode}'),
                itemOnly(data),
                Text(
                  'Rp. ${getTotal(data)}',
                  style: bodyText1,
                ),
                ElevatedButton(
                    onPressed: () async {
                      String url = await getPaymentLink(widget.kode, getTotal(data), data);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => payScreenweb(
                            paymentLink: url, 
                            kodeTransaksi: widget.kode,
                          ),
                        ),
                      );
                    },
                    child: Text('Pay Ticket'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFFCC050)),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Color(0xFFFCC050)))))),
              ],
            ),
          )
        : SingleChildScrollView(
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
                        data: widget.kode,
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
                        widget.kode,
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
                              widget.kode,
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
