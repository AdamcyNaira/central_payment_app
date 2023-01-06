import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../util/constants.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        height: screenHeight(context) * 0.45,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
            "PAY MUBI \n  Payment System ",
            style: GoogleFonts.notoSerif(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Constants.kTextColor),
            textAlign: TextAlign.center,
          ),
          const YMargin(20),
          Text(
            "PAY MUBI is a central payment system for collection of all payments due to Federal Polytechnic Mubi (i.e. Result Verification, Transcript Processing Fee, Tuition Fee, Original Result Processing Fee etc)",
            style: GoogleFonts.alike(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const YMargin(50),
          MaterialButton(
                    color: Color(0XFF1AA37A),
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 14),
                    ),
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF1AA37A), width: 2),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
                child: Container(
                    padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                    height: screenHeight(context),
                    width: screenWidth(context),
                    child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                width: screenWidth(context) * 0.80,
                                height: screenHeight(context) * 0.20,
                              ),
                              const YMargin(5),
                              Text(
                                "Central Payment System(CPS)",
                                style: GoogleFonts.inter(
                                    fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black54),
                                textAlign: TextAlign.center,
                              ),
                              const YMargin(3),
                              Text(
                                "Secured & Flexible Payment",
                                style: GoogleFonts.alike(
                                    fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black54),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                ),
              );
  }
}
