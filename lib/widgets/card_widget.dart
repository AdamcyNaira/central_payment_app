// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import '../util/constants.dart';
class TransactionTile extends StatelessWidget {
  String? title;
  String? subTitle;
  String? amount;
  IconData? icon;

  TransactionTile({Key? key, this.title, this.subTitle, this.amount, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                      child: Container(
                        width: screenWidth(context),
                          decoration: BoxDecoration(
                            color: Constants.kWhiteColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                            children: [
                               ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                height: 40,
                                width: 40,
                                color: Constants.kLightGreyColor,
                                child: Icon(icon!, color: Constants.kGreyColor,),
                              ),
                            ),
                             const XMargin(8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    title!,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Constants.kTextColor,
                                    ),
                                  ),
                                  const YMargin(1),
                                  Text(
                                    subTitle!,
                                    style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ), 
                          Text(
                                    "N${amount!}",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Constants.kTextColor,
                                    ),),
                            ],
                          ),
                          
                        ),
                    );
  }

}

                    

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: screenHeight(context) * 0.23,
                  width: screenWidth(context),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Card(
                    color: Constants.kLightGreyColor,
                    elevation: 5,
                    child: InkWell(
                      highlightColor: Constants.kPrimaryColor.withOpacity(0.2),
                      onTap: () {},
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8, left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const YMargin(5),
                                  Text(
                                    'Do you have any issues related to payment?',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        color: Constants.kGreyColor,
                                        fontSize: 20),
                                  ),
                                  const YMargin(10),
                                  Text(
                                        'Kindly click the button below to log complain',
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w800,
                                            color: Constants.kTextColor,
                                            fontSize: 12),
                                      ),
                                 
                                  const YMargin(1),
                                 
                                ],
                              ),
                            ),
                          ),
                          const YMargin(10),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Image.asset(
                                'assets/images/pay.png',
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      )
                       ),
                  ))
            ]
                  );
 
  }
}