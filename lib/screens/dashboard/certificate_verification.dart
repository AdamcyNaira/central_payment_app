import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:result_verification/model/payment_model.dart';
import 'package:result_verification/providers/payent_state.dart';
import 'package:result_verification/util/constants.dart';
import 'package:result_verification/widgets/card_widget.dart';
import 'package:result_verification/widgets/dashboard_widget.dart';

import '../../widgets/form_widget.dart';
import '../../widgets/general_widget.dart';

class CertificateVerification extends ConsumerStatefulWidget {
  const CertificateVerification({super.key});

  @override
  ConsumerState<CertificateVerification> createState() => _CertificateVerificationState();
}

class _CertificateVerificationState extends ConsumerState<CertificateVerification> {
 TextEditingController  certNoController = TextEditingController();
 String certNo = "";
  Payment _payment = Payment();
  @override
  Widget build(BuildContext context) {
    final _user = ref.watch(payStateProvider).user;
    return Scaffold(
      backgroundColor: Constants.kBackgroundColor,
      appBar: PreferredSize(
        child: largeAppbar(
          context: context,
        icon1: Icons.arrow_back_ios_new,
        route1: () => Navigator.of(context).pop(),
        title: "",
        banner: "assets/images/cert.jpg",
        caption: "Verify Certificate",
        ), preferredSize: Size.fromHeight(220),
      ), 
      body: Container(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
        children: [
           inputLabel(title: 'Certificate No.'),
                          buildTextInput(
                            controller: certNoController,
                            keyboardType: TextInputType.text,
                            onSave: (val) {
                                setState(() {
                                  certNo = val.toString();
                                });
                            },
                            onChanged: (val) {
                                setState(() {
                                  certNo = val.toString();
                                });
                            },
                            hintText: 'Enter certificate number',
                          ),
                           Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                                height: 50,
                                width: 50,
                                color: Color(0XFFdcf3fb),
                                child: Center(
                                  child: Text(
                                  "You will be charged NGN5,000 for this service",
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color:  Color(0XFF8eaebe),
                                  ),
                                ),
                                ),
                              ),
                          ),
                           ),
                     
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: GestureDetector(
                          onTap: () {
                             if (certNo == "") {
                                  showErrorDialog(
                                    context: context,
                                    title: "Oops!",
                                    msg: 'Certificate number field can not be empty!',
                                  );
                                  return;
                                }
                            final invoice = Payment.fromJson({
                        "id": "10",
                        "userId": _user.id.toString(),
                        "paymentType": "Certificate Verification Fee",
                        "Amount": "5000",
                        "paymentID": "0010",
                        "date": "2023-03-01",
                        "status": "Pending",
                        "orderID": "123456789",
                      });
                      ref.watch(payStateProvider).setCertificateNo(certNo);
                      ref.read(payStateProvider).setInvoice(invoice);
                      Navigator.pushNamed(context, "/payment_review");
                          },
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
                       ),
        
        ],
      ),
      ),
    );
  }
}
