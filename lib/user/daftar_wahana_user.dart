import 'package:desa_wisata/models/cart.dart';
import 'package:desa_wisata/theme.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:google_fonts/google_fonts.dart';

class DaftarWahanaUser extends StatefulWidget {
  const DaftarWahanaUser({Key? key, required this.idWahana, required this.indexWahana}) : super(key: key);

  final String idWahana;
  final int indexWahana;

  @override
  State<DaftarWahanaUser> createState() => _DaftarWahanaUserState();
}

class _DaftarWahanaUserState extends State<DaftarWahanaUser> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget customBottomNav() {
      return Container(
        height: 150,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: subtitle1,
                  ),
                  Text("Rp. ${getTotal()}", style: title2),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 0.75,
              color: primaryColor,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Cart',
                        style: title2.copyWith(
                          color: textColor1,
                        )),
                    Icon(
                      Icons.arrow_forward,
                      color: secondaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background2,
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
          'Rides',
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
                      text: 'Entrance ticket',
                    ),
                    Tab(
                      text: 'Ride Tickets',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      FutureBuilder(
                        future: getTiketMasuk(),
                        builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5.0,
                                        left: 10.0,
                                        right: 10.0),
                                    child: 
                                      TiketMasuk(
                                        htm: snapshot.data[widget.indexWahana]['htm'], 
                                        nama: snapshot.data[widget.indexWahana]['name'], 
                                        id:snapshot.data[widget.indexWahana]['id'], 
                                        refresh: refresh,),
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            // return Text('Data Error');
                          }),
                      FutureBuilder(
                        future: getWisata(widget.idWahana),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            // return Text(snapshot.data.toString());
                              return 
                              ListView.builder(
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5.0,
                                            left: 10.0,
                                            right: 10.0),
                                        child:
                                        //Text(snapshot.data[index].toString()),
                                        dataWidget(
                                          snapshot: snapshot,
                                          index: index,
                                          refresh: refresh,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                itemCount: snapshot.data.length,
                              );
                            } 
                          else {
                            return Center(
                              child: 
                              //Text('data tidak tersedia')
                              CircularProgressIndicator(),
                            );
                          }

                          // return Text('Data Error');
                        }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: customBottomNav(),
    );
  }

  final String apiUrl = 'http://go-wisata.id/api/tempat/';

  Future<List<Map<String, dynamic>>?> fetch() async {
    http.Response response = await http.get(Uri.parse(apiUrl));
    // if (response.statusCode != 200) return null;
    if (response.statusCode != 200){
      SnackBar snackBar = SnackBar(
        content: Text(json.decode(response.body)['data']['message']),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return null;
    } 
    return List<Map<String, dynamic>>.from(json.decode(response.body)['data']);
  }

  Future getWisata(String idTempat) async {
    String fullUrl = apiUrl+idTempat.toString();
    var response = await http.get(Uri.parse(fullUrl));
    if (response.statusCode != 200) return null;
    return json.decode(response.body);
  }

  Future getTiketMasuk() async {
    var response = await http.get(Uri.parse('http://go-wisata.id/api/tempat'));
    return json.decode(response.body);
  }
}

class TiketMasuk extends StatefulWidget {
  const TiketMasuk({ Key? key, required this.htm, required this.nama, required this.id, required this.refresh }) : super(key: key);

  final int htm;
  final String nama;
  final int id;
  final Function() refresh;

  @override
  _TiketMasukState createState() => _TiketMasukState();
}

class _TiketMasukState extends State<TiketMasuk> {
  int total = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 0, 5),
                              child: Text(
                                "${widget.nama}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 0, 5),
                              child: Text(
                                'Description of Rides Ticket Place',
                                // "Get all the features at a discount for yearly membership.",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 0, 5),
                              child: Text(
                                //Harga Tempat Tiket Wahana
                                "Rp. ${widget.htm}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFCC050),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 0, 5),
                              child: Text(
                                'per person',
                                // widget.snapshot.data[widget.index]
                                //         ['deskripsi_harga'] ??
                                //     '-',
                                // "Get all the features at a discount for yearly membership.",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Row(
                              //add to cart
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        if (total > 1) {
                                          setState(() {
                                            total--;
                                            widget.refresh();
                                          });
                                        }
                                        minusCart(
                                          widget.id,
                                          widget.id,
                                          "Tiket Masuk ${widget.nama}",
                                          'tiket masuk',
                                          widget.htm,
                                          'image',
                                        );
                                      },
                                      child: Text("-"),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xFFFCC050)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  side: BorderSide(
                                                      color: Color(
                                                          0xFFFCC050)))))),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      getQty( 
                                        widget.id,
                                        widget.id,
                                        "Tiket Masuk ${widget.nama}",
                                        'tiket masuk',
                                        widget.htm).toString(),
                                      //total.toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFFFFF8EC)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                            BorderRadius.circular(10.0),
                                        )
                                      )
                                    )
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // deleteWahana(widget.id);
                                      setState(() {
                                        total += 1;
                                        widget.refresh();
                                      });
                                      addCart(
                                        widget.id,
                                        widget.id,
                                        "Tiket Masuk ${widget.nama}",
                                        'tiket masuk',
                                        widget.htm,
                                        'image',
                                      );
                                    },
                                    child: Text("+"),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFFFCC050)),
                                      shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(RoundedRectangleBorder(
                                          borderRadius:
                                            BorderRadius.circular(10.0),
                                          )
                                        )
                                    )
                                  )
                                ]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final String baseUrl = 'http://go-wisata.id/';

class dataWidget extends StatefulWidget {
  const dataWidget({
    Key? key,
    required this.snapshot,
    required this.index,
    required this.refresh,
  }) : super(key: key);

  final AsyncSnapshot snapshot;
  final int index;
  final Function() refresh;

  @override
  State<dataWidget> createState() => _dataWidgetState();
}

class _dataWidgetState extends State<dataWidget> {
  int total = 0;
  @override
  Widget build(BuildContext context) {
    // print(widget.snapshot);
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                // ClipRRect(
                //           borderRadius: BorderRadius.only(
                //             bottomLeft: Radius.circular(8),
                //             bottomRight: Radius.circular(0),
                //             topLeft: Radius.circular(8),
                //             topRight: Radius.circular(0),
                //           ),
                //           child: Image.asset(
                //             'assets/image/wahana_kapal.jpg'
                //               ),
                //         ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                      baseUrl +
                          'images/' +
                          widget.snapshot.data[widget.index]['image'],
                          width: MediaQuery.of(context).size.width * 0.25,
                          // height: MediaQuery.of(context).size.height * 1,
                      fit: BoxFit.cover, loadingBuilder:
                          (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }),
                ),
                SizedBox(width: 10),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 0, 5),
                              child: Text(
                                //Nama Tempat Tiket Wahana
                                widget.snapshot.data[widget.index]
                                    ['name']??
                                    '-',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 0, 5),
                              child: Text(
                                //Deskripsi Tempat Tiket Wahana
                                widget.snapshot.data[widget.index]
                                        ['deskripsi']??
                                    '-',
                                // "Get all the features at a discount for yearly membership.",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 0, 5),
                              child: Text(
                                //Harga Tempat Tiket Wahana
                                "Rp. " +
                                    widget.snapshot.data[widget.index]['harga'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFCC050),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 0, 5),
                              child: Text(
                                // 'Deskripsi Harga Tiket Wahana',
                                widget.snapshot.data[widget.index]
                                        ['deskripsi_harga'] ??
                                    '-',
                                // "Get all the features at a discount for yearly membership.",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Row(
                              //add to cart
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        if (total > 1) {
                                          setState(() {
                                            total--;
                                            widget.refresh();
                                          });
                                        }
                                        minusCart(
                                          widget.snapshot.data[widget.index]['id'],
                                          widget.snapshot.data[widget.index]['tempat_id'],
                                          widget.snapshot.data[widget.index]['name'],
                                          'tiket',
                                          int.parse(widget.snapshot.data[widget.index]['harga']),
                                          widget.snapshot.data[widget.index]['image'].toString(),
                                        );
                                      },
                                      child: Text("-"),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xFFFCC050)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  side: BorderSide(
                                                      color: Color(
                                                          0xFFFCC050)))))),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                        getQty( 
                                          widget.snapshot.data[widget.index]['id'],
                                          widget.snapshot.data[widget.index]['tempat_id'],
                                          widget.snapshot.data[widget.index]['name'],
                                          'tiket',
                                          int.parse(widget.snapshot
                                        .data[widget.index]['harga'])
                                        ).toString(),
                                        // total.toString(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xFFFFF8EC)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )))),
                                  ElevatedButton(
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                      // deleteWahana(widget.id);
                                      setState(() {
                                        total += 1;
                                        widget.refresh();
                                      });
                                      addCart(
                                        widget.snapshot.data[widget.index]['id'],
                                        widget.snapshot.data[widget.index]['tempat_id'],
                                        widget.snapshot.data[widget.index]['name'],
                                        'tiket',
                                        int.parse(widget.snapshot.data[widget.index]['harga']),
                                        widget.snapshot.data[widget.index]['image'].toString(),
                                      );
                                    },
                                    child: Text("+"),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFFFCC050)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                          )
                                      )
                                    )
                                  )
                                ]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void addCart(int id ,int idtempat , String name, String kategori, int harga, String image) {
  var found = false;
  cartList.forEach((element) {
    if (element.nama == name &&
        element.kategori == kategori &&
        element.id == id) {
      found = true;
      element.qty += 1;
    }
  });
  if (found) {
    found = false;
  } else {
    Cart cart = Cart(
      id: id,
      idtempat: idtempat,
      nama: name,
      qty: 1,
      harga: harga,
      kategori: kategori,
      image: image,
    );
    cartList.add(cart);
  }
}

void minusCart(int id ,int idtempat ,String name ,String kategori ,int harga ,String image) {
  if(cartList.isNotEmpty){
    var found = false;
    for (var element in cartList) {
      if (element.nama == name &&
        element.kategori == kategori &&
        element.id == id) {
        found = true;
        if (element.qty >= 1) {
          element.qty -= 1;

          if (element.qty < 1) {
            cartList.remove(element);
          }
        }
      }
    }
    if (found) {
      found = false;
    } else {
      Cart cart = Cart(
        id: id,
        idtempat: idtempat,
        nama: name,
        qty: 1,
        harga: harga,
        kategori: kategori,
        image: image);
      }
  }
}

int getQty(int id, int idtempat, String name ,String kategori ,int harga) {
  int tmp = 0;
  for (var element in cartList) {
    if (element.nama == name &&
      element.kategori == kategori &&
      element.id == id &&
      element.idtempat == idtempat) {
      tmp = element.qty;
    }
  }
  return tmp;
}

int getTotal() {
  int total = 0;
  if (cartList.isEmpty) {
    total = 0;
  }
  else{
    for (var x in cartList) {
      int y = x.qty * x.harga;
      total += y;
    }
  }
  return total;
}
