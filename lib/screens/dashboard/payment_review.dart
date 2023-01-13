import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import '../../util/constants.dart';
import '../../widgets/dashboard_widget.dart';
import '../../widgets/general_widget.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:math';
class PaymentReview extends StatefulWidget {
  const PaymentReview({super.key});

  @override
  State<PaymentReview> createState() => _PaymentReviewState();
}

class _PaymentReviewState extends State<PaymentReview> {

    final formKey = new GlobalKey<FormState>();
  Random random = new Random();
   

 bool isLoading = false;
  var result;
  int? amountPayable;
  int? orderID;
  String? refID;


  var publicKey = 'pk_test_900f6286d49dd3d323d4b8e4530501fd060356d6';
  final plugin = PaystackPlugin();

  String _getReference() {
    return '${DateTime.now().millisecondsSinceEpoch}';
  }
  
  _initiatePayment() async{
    Charge charge = Charge()
       ..amount = amountPayable!  * 100
       ..reference =  refID
        // or ..accessCode = _getAccessCodeFrmInitialization()
       ..email = userEmail;
        CheckoutResponse response = await plugin.checkout(
          context,
          method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
          charge: charge,
        );

        if (response.status) {
          _updateUserTransaction(refID, orderID);
        }
  }

  
    _confirmOrder(context) async{
          result = await Connectivity().checkConnectivity();
          if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
                  setState(() {
                        isLoading = true;
                      });
                      isLoading
                          ? showLoadingDialog(context)
                          : Navigator.of(context, rootNavigator: true).pop('dialog');
                      Timer(Duration(seconds: 3), () {
                         setState(() {
                          isLoading = false;
                        });
                        !isLoading
                            ? Navigator.of(context, rootNavigator: true).pop('dialog')
                            : showLoadingDialog(context);
                        //CallBackFunction Here
                        _initiateUserTransaction();
                       
                      });
                        //Success Page Call Here
            }else{
                showInternetError(context: context, msg: "Please check your connection and try again!");
            }
  }

  _initiateUserTransaction() async {
      //     final response = {
      //       "request": "INITIATE TRANSACTION",
      //       "user": userID.toString(),
      //       "item": widget.orderType.toString(),
      //       "statusCode": widget.noOfItems.toString(),
      //       "amount": widget.buyAmount.toString(),
      //       "orderID": orderID.toString()
      // };

    bool  res = true;

      if (res == true) {
          _initiatePayment();
      } 
      
     
  }


  _updateUserTransaction(refID, orderID) async {
      //     final response =
      //       await http.post(Uri.parse('https://teamcoded.com.ng/table_water.php'), body: {
      //       "request": "UPDATE TRANSACTION",
      //       "user": userID.toString(),
      //       "quantity": widget.noOfItems.toString(),
      //       "id": 1.toString(), 
      //       "ref": refID.toString(),
      //       "orderID": orderID.toString()
      // });
      bool  res = false;
      if (res == true) {
         Navigator.pushNamed(context, "/");
      }
      
     
  }

 
getData()async {
      setState(() {
      userID = "22";
      userEmail = "adammusa89@gmail.com";
      });
}


@override
  void initState() {
    plugin.initialize(publicKey: publicKey);
    getData();
    amountPayable = 10000 + 20;
    orderID = random.nextInt(1000000000);
    refID = _getReference();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.kBackgroundColor,
      appBar:  twoButtonsAppbar(
        context: context,
        icon1: Icons.arrow_back_ios_new,
        route1: () => Navigator.of(context).pop(),
        title: "Payment Review",
      ),
      body:  Container(
              padding: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                  children: [
                     Container(
                      height: screenHeight(context) * 0.18,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Tuition Fee",
                                style: TextStyle(color: Constants.kIconsColor, fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            "Amount Payable",
                            style: TextStyle(color: Constants.kIconsColor,  fontSize: 16),
                        ),
                            Text(
                            "NGN 12,000",
                            style: TextStyle(color: Constants.kIconsColor, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                          ],
                          ),
                          ],
                        ),
                        
                      ),
                      YMargin(20),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            "Payer's Name",
                            style: TextStyle(color: Constants.kIconsColor,  fontSize: 14),
                        ),
                            Text(
                            "Adam Musa Yau",
                            style: TextStyle(color: Constants.kIconsColor, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                          ],
                          ),
                          YMargin(10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            "Payer's Email",
                            style: TextStyle(color: Constants.kIconsColor,  fontSize: 14),
                        ),
                            Text(
                            "adammusa89@gmail.com",
                            style: TextStyle(color: Constants.kIconsColor, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                          ],
                          ),
                          YMargin(10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            "Payer's Phone",
                            style: TextStyle(color: Constants.kIconsColor,  fontSize: 14),
                        ),
                            Text(
                            "08063017470",
                            style: TextStyle(color: Constants.kIconsColor, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                          ],
                          ),
                          Divider(height: 50,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            "Service Charges",
                            style: TextStyle(color: Constants.kIconsColor,  fontSize: 14),
                        ),
                            Text(
                            "NGN 50",
                            style: TextStyle(color: Constants.kIconsColor, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                          ],
                          ),
                          YMargin(10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            "Total Amount",
                            style: TextStyle(color: Constants.kIconsColor,  fontSize: 14),
                        ),
                            Text(
                            "NGN 12,050",
                            style: TextStyle(color: Constants.kIconsColor, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                          ],
                          ),
                          ],
                        ),
                        
                      ),
                      YMargin(250),
                       GestureDetector(
                        onTap: () => _initiateUserTransaction(),
                         child: Container(
                          decoration: BoxDecoration(
                              color: Constants.kIconsColor,
                              borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                          child: Text(
                              "PAY NOW",
                              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                          ),
                      ),
                       ),
                  ],
                        ),
      ),
    );
  }
}