import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class payScreenweb extends StatefulWidget {
  const payScreenweb({Key? key, required this.paymentLink, required this.kodeTransaksi});

  final String paymentLink;
  final String kodeTransaksi;

  @override
  State<payScreenweb> createState() => _payScreenwebState();
}

class _payScreenwebState extends State<payScreenweb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Midtrans Payment'),
      ),
      body: WebView(
        initialUrl: widget.paymentLink.toString(),
        javascriptMode: JavascriptMode.unrestricted,
        gestureRecognizers: Set()
        ..add(Factory<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer())),
        // gestureRecognizers: [
        //            Factory<OneSequenceGestureRecognizer>(
        //             () => new EagerGestureRecognizer(),
        //           ),
        //         ].toSet(),
        onPageFinished: (String url){
          checkPayment(widget.kodeTransaksi);
          print('finish');
        },
      ),
    );
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
  }
}