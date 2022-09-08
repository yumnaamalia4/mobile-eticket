import 'dart:convert';

import 'package:desa_wisata/data.dart';
import 'package:desa_wisata/models/cart.dart';
import 'package:desa_wisata/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  DateTime? datePicked;
  bool checkoutIsProcessing = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final String baseUrl = 'http://go-wisata.id/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Color(0xFFF1F4F8),
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFF1D2429),
                          size: 30,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                      child: Text(
                        'Kembali',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: Text(
                    'Keranjang',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [],
          elevation: 0,
        ),
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                  itemCount: cartList.length,
                  itemBuilder: (context, index) {
                    final Cart cart = cartList[index];
                    if (cartList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_rounded,
                              color: primaryColor,
                              size: 18,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Opss! Keranjangmu masih kosong',
                              style: title2,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Ayo cari tiket wisatamu',
                              style: subtitle1,
                            ),
                            Container(
                              width: 154,
                              height: 44,
                              margin: EdgeInsets.only(
                                top: 20,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      '/DaftarWahanaUser', (route) => false);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Cari tiket',
                                  style: title1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        width: double.infinity,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x320E151B),
                              offset: Offset(0, 1),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                baseUrl + 'images/' + cart.image,
                                width: 80,
                                height: double.infinity,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      // height: 90,
                                      constraints:
                                          BoxConstraints(maxWidth: 100),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 5),
                                            child: Text(
                                              cart.nama,
                                              style: GoogleFonts.montserrat(
                                                color: Color(0xFF1D2429),
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            cart.harga.toString(),
                                            style: GoogleFonts.montserrat(
                                              color: Color(0xFF57636C),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                            child: Text(
                                              'Jumlah: ' + cart.qty.toString(),
                                              style: GoogleFonts.montserrat(
                                                color: Color(0xFF57636C),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
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
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Color(0xFF57636C),
                                size: 20,
                              ),
                              onPressed: () {
                                print('plus one item');
                                setState(() {
                                  cart.qty += 1;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: Color(0xFF57636C),
                                size: 20,
                              ),
                              onPressed: () {
                                print('minus one item');
                                setState(() {
                                  if (cart.qty > 1) {
                                    cart.qty -= 1;
                                    if(cart.qty == 0){
                                      cartList.remove(cart);
                                    }
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                color: Color(0xFFE86969),
                                size: 20,
                              ),
                              onPressed: () {
                                print('delete item');
                                setState(() {
                                  cartList.remove(cart);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  }),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFFCFD4DB),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 5, 12, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            datePicked != null
                                ? Text(
                                    '${datePicked?.day.toString()}-${datePicked?.month.toString()}-${datePicked?.year.toString()}')
                                : Text(
                                    // valueOrDefault<String>(
                                    //   dateTimeFormat('d/M/y', datePicked),
                                    'Tiket untuk tanggal berapa?',
                                    // ),
                                    style: GoogleFonts.montserrat(
                                      color: Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                            InkWell(
                              onTap: () async {
                                // pilihTanggal
                                DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100));
                                setState(() => datePicked = newDate);
                              },
                              child: Icon(
                                Icons.date_range_outlined,
                                color: Color(0xFF57636C),
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 24),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Total',
                        style: GoogleFonts.montserrat(
                          color: Color(0xFF57636C),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.info_outlined,
                          color: Color(0xFF57636C),
                          size: 18,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ],
                  ),
                  Text(
                    // 'Rp. 20.000',
                    getTotal().toString(),
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF1D2429),
                      fontSize: 32,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (cartList.isEmpty) {
                  SnackBar snackBar = SnackBar(
                    content: Text('Tambahkan tiket terlebih dahulu'),
                    backgroundColor: Colors.red,
                  );
                } else {
                  // print(datePicked);
                  if (datePicked != null) {
                    checkout();
                  } else {
                    SnackBar snackBar = SnackBar(
                      content: Text('Select Date first'),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              },
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFFFCC050),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x320E151B),
                      offset: Offset(0, -2),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                alignment: AlignmentDirectional(0, -0.35),
                child: checkoutIsProcessing
                    ? const CircularProgressIndicator()
                    :Text(
                  'Pay (Rp. ' + getTotal().toString() + ')',
                  style: title1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future checkout() async {
    var response;
    var dataproduk = [];
    var datauser = [];
    for (var x in cartList) {
      var tmp = {
        'id': x.id,
        'tempat_id':x.idtempat,
        'nama': x.nama,
        'qty': x.qty,
        'kategori': x.kategori,
        'harga': x.harga,
      };
      dataproduk.add(tmp);
    }
    for (var x in dataList) {
      var user = {
        'user_id': x.id,
        'name': x.name,
        'email': x.email,
        'telp': x.telp,
      };
      datauser.add(user);
    }
    var user = jsonEncode(datauser.last);
    for(var y in dataproduk) {
      var satuan = jsonEncode(y);
      response = await http.post(Uri.parse("http://go-wisata.id/api/checkout"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'dataproduk': satuan,
        'datauser': user,
        'date': datePicked.toString(),
      }),
      );
      // user loading 
      setState(() {
        checkoutIsProcessing = true;
      });
      
      // print(response);
    } 
    if (response.statusCode != 200) {
      // print(response.body.toString());
      SnackBar snackBar = SnackBar(
        content: Text('Gagal untuk checkout'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        checkoutIsProcessing = false;
      });
      Map<String, dynamic> temp = json.decode(response.body);
      SnackBar snackBar = SnackBar(content: Text(temp['data']));
      // SnackBar snackBar = SnackBar(content: Text('Berhasil checkout'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // clear cart  
      cartList.clear();
       Navigator.pushNamedAndRemoveUntil(context, '/home-user', (route) => false);

      // Navigator.pushNamed(context, '/DaftarPesananUser');
    }
  }
}

int getQty() {
  var qty = cartList[0];
  print(qty);
  return qty.qty;
  // for (var x in cartList) {
  // if (x.id == index) {
  //   return x.qty;
  // }
  // }
}

int getTotal() {
  int total = 0;
  for (var x in cartList) {
    int y = x.qty * x.harga;
    total += y;
  }
  return total;
}
