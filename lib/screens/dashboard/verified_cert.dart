import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:result_verification/providers/payent_state.dart';

import '../../util/constants.dart';
import '../../widgets/dashboard_widget.dart';

class VerifiedCertificate extends ConsumerStatefulWidget {
  const VerifiedCertificate({super.key});

  @override
  ConsumerState<VerifiedCertificate> createState() => _VerifiedCertificateState();
}

class _VerifiedCertificateState extends ConsumerState<VerifiedCertificate> {

    final formKey = new GlobalKey<FormState>();


 bool isLoading = false;
   
  

  @override
  Widget build(BuildContext context) {
    final _user = ref.watch(payStateProvider).user;
    final _invoice = ref.watch(payStateProvider).invoice;
    final _certNo = ref.watch(payStateProvider).certificateNo;
    return Scaffold(
        backgroundColor: Constants.kBackgroundColor,
      appBar:  twoButtonsAppbar(
        context: context,
        icon1: Icons.arrow_back_ios_new,
        route1: () => Navigator.of(context).pop(),
        title: "Student Certificate Status",
      ),
      body:  Container(
              padding: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                  children: [
                     
                      YMargin(20),
                      Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                                height: 80,
                                color: Color(0XFFdcf3fb),
                                child: Center(
                                  child: Text(
                                  "The certificate is valid and awarded to John Doe on ${dateFormater(DateTime.now().toString(), 'yMMMMd') }",
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color:  Color.fromARGB(255, 29, 43, 49),
                                    height: 1.9
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                ),
                              ),
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
                            "Student ID",
                            style: TextStyle(color: Constants.kIconsColor,  fontSize: 14),
                        ),
                            Text(
                            "CSC/22/3522",
                            style: TextStyle(color: Constants.kIconsColor, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                          ],
                          ),

                          Divider(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            "Student Name",
                            style: TextStyle(color: Constants.kIconsColor,  fontSize: 14),
                        ),
                            Text(
                            "John Doe",
                            style: TextStyle(color: Constants.kIconsColor, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                          ],
                          ),
                          Divider(height: 40,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            "Certificate No.",
                            style: TextStyle(color: Constants.kIconsColor,  fontSize: 14),
                        ),
                            Text(
                            _certNo.toString(),
                            style: TextStyle(color: Constants.kIconsColor, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                          ],
                          ),
                          Divider(height: 40,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            "Award Date",
                            style: TextStyle(color: Constants.kIconsColor,  fontSize: 14),
                        ),
                            Text(
                              dateFormater(DateTime.now().toString(), 'yMMMMd') ,
                            style: TextStyle(color: Constants.kIconsColor, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                          ],
                          ),
                          Divider(height: 30,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            "Degree Awarded",
                            style: TextStyle(color: Constants.kIconsColor,  fontSize: 14),
                        ),
                            Text(
                            "B.sc Computer Science",
                            style: TextStyle(color: Constants.kIconsColor, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                          ],
                          ),
                          Divider(height: 40,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            "Class Of Degree",
                            style: TextStyle(color: Constants.kIconsColor,  fontSize: 14),
                        ),
                            Text(
                             "Second Class Upper",
                            style: TextStyle(color: Constants.kIconsColor, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                          ],
                          ),
                          ],
                        ),
                        
                      ),
                   Padding(
                         padding: const EdgeInsets.only(top: 20.0),
                         child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, "/dashboard");
                          },
                           child: Container(
                            decoration: BoxDecoration(
                                color: Constants.kIconsColor,
                                borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                            child: Text(
                                "Goto Dashboard",
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