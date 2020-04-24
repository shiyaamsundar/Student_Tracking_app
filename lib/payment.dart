import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Pay extends StatefulWidget {
  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {

  Razorpay _razorpay;
  int totalamt = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay=Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlepaymentsuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlepaymenterror);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlepaymentwallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }


  void opencheckout(var totalamt)async{
    var options={
      'key':'rzp_test_kGshMr1bT6d9No',
      'amount':totalamt,
      'name':'clg',
      'description':'Test payment',
      'prefill':{'contact':'9626200428','email':'aaa10000@gmail.com',},
      'external':{
        'wallets':['paytm']
      }
    };
    try{
      _razorpay.open(options);
    }
    catch(e)
    {
      debugPrint(e);
    }
  }
  void _handlepaymentsuccess(PaymentSuccessResponse response)
  {
    Fluttertoast.showToast(msg:"Success"+response.paymentId);
  }
  void _handlepaymentwallet(ExternalWalletResponse response)
  {
    Fluttertoast.showToast(msg:"External wallet"+response.walletName);
  }
  void _handlepaymenterror(PaymentFailureResponse response)
  {
    Fluttertoast.showToast(msg:"Error"+response.code.toString()+"+"+response.message);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LimitedBox(
              maxWidth: 150,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration:
                InputDecoration(hintText: '   Enter the amount to be paid'),
                onChanged: (val) {


                  totalamt = num.parse(val)*100;

                  print(val);
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              onPressed: () {opencheckout(totalamt);},
              child: Text(
                'Make Payment',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
