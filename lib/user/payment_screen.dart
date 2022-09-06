import 'package:flutter/material.dart';
import 'package:midpay/midpay.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({ Key? key, required this.kodeTransaksi, required this.data, required this.total }) : super(key: key);

  final String kodeTransaksi;
  final List data;
  final int total;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final midpay = Midpay();

  //test payment
  _testPayment() {
    //for android auto sandbox when debug and production when release
    midpay.init("SB-Mid-server-OLGi2F3Pcf_ivfQla_Qf59kG", 'https://api.sandbox.midtrans.com', environment: Environment.sandbox);
    midpay.setFinishCallback(_callback);
    var midtransCustomer = MidtransCustomer(
        'test', 'testing', 'testing@mail.com', '085704703691');
    List<MidtransItem> listitems = [];
    var midtransItems = MidtransItem('IDXXX', 5000, 2, 'Tiket masuk');
    listitems.add(midtransItems);
    var midtransTransaction = MidtransTransaction(
        100000, midtransCustomer, listitems,
        skipCustomer: true);
    midpay
        .makePayment(midtransTransaction)
        .catchError((err) => print("ERROR $err"));
  }

  //calback
  Future<void> _callback(TransactionFinished finished) async {
    print("Finish $finished");
    return Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          title: const Text('Midpay Plugin example app'),
        ),
        body:  Center(
          child: ElevatedButton(
            child: const Text("Payment"),
            onPressed: () => _testPayment(),
          ),
        ),
    );
  }
}