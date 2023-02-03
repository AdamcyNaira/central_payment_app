// ignore_for_file: deprecated_member_use, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import '../../model/payment_model.dart';
import '../../providers/payent_state.dart';
import '../../util/constants.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/dashboard_widget.dart';
import 'package:barcode_widget/barcode_widget.dart';

class UserAccount extends ConsumerStatefulWidget {
  const UserAccount({Key? key}) : super(key: key);
  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends ConsumerState<UserAccount> {
  bool isPersonalInfo = true;

  @override
  Widget build(BuildContext context) {
    final _user = ref.watch(payStateProvider).user;
    List<Payment> _payments = ref.watch(payStateProvider).payments.where((element) => element.userId == _user.id).toList();
    return Scaffold(
      appBar: twoButtonsAppbar(
        context: context,
        icon1: Icons.arrow_back_ios_new,
        route1: () => Navigator.of(context).pop(),
        title: "User Profile",
        icon2: Ionicons.qr_code_outline,
        route2: () => {_showQRCodeDialog()},
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
        height: screenHeight(context),
        width: screenWidth(context),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Constants.kBackgroundColor,
              Constants.kBackgroundColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          primary: true,
          shrinkWrap: true,
          children: [
            userInfoCard(
              context: context,
              name: _user.name ?? "N/A",
              img: _user.name ?? "N/A",
              specialization: _user.phone ?? "N/A",
              email: _user.email ?? "N/A",
              isPersonalInfo: isPersonalInfo,
              route: () {
                setState(() {
                  isPersonalInfo = true;
                });
              },
              route2: () {
                setState(() {
                  isPersonalInfo = false;
                });
              },
            ),
            isPersonalInfo
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Card(
                        color: const Color(0xffFAFAFA),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 0, 50),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textCard(
                                      context: context,
                                      value:_user.name ?? "N/A",
                                      key: "Name",
                                    ),
                                    textCard(
                                      context: context,
                                      value:_user.phone ?? "N/A",
                                      key: "Phone Number",
                                    ),
                                    textCard(
                                      context: context,
                                      value: _user.email ?? "N/A",
                                      key: "Email; Address",
                                    ),
                                  ],
                                ),
                              ),
                             
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: _payments.length > 0 ?
                     ListView.builder(
                      shrinkWrap: true,
                  itemCount: _payments.length,
                  itemBuilder: (context, index) {
                    return TransactionTile(
                      icon: Ionicons.wallet_outline,
                      title: _payments[index].paymentType,
                      subTitle:  dateFormater(_payments[index].date.toString(), 'yMMMMd'),
                      amount:  _payments[index].amount,
                    );
                      },
                )
                :
                ClipRRect(
                  borderRadius: BorderRadius.circular(35.0),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    color: Colors.white,
                    height: screenHeight(context) * 0.3,
                    child: Center(
                      child: Text(
                        "No Transaction Found",
                      style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Constants.kTextColor,
                              ),
                      ),
                    ),
                  ),
                ),
                    ),
                  ),
                               Padding(
                         padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                         child: GestureDetector(
                          onTap: () {
                            Constants.sharedPref!.clear();
                            Navigator.pushNamedAndRemoveUntil(
            context, '/home', (route) => false);
                          },
                           child: Container(
                            decoration: BoxDecoration(
                                color: Constants.kIconsColor,
                                borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                            child: Text(
                                "LOGOUT",
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

  _showAlert(context) {
    final _user = ref.watch(payStateProvider).user;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Flight Details",
                //   style: GoogleFonts.inter(
                //     color: Constants.kPrimaryColor,
                //     fontSize: 16,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                // Divider(
                //   height: 20,
                //   color: Constants.kPrimaryColor,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textCard(
                      context: context,
                      value:
                          _user.name ?? "N/A",
                      key: _user.name ?? "N/A",
                    ),
                    Icon(Ionicons.airplane_outline),
                    textCard(
                      context: context,
                      value:
                          _user.name ?? "N/A",
                      key: _user.name ?? "N/A",
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textCard(
                      context: context,
                      value: _user.name ?? "N/A",
                      key: "Depature",
                    ),
                    textCard(
                      context: context,
                      value: _user.name ?? "N/A",
                      key: "Arrival",
                    ),
                  ],
                ),
                Divider(),
                textCard(
                  context: context,
                  value: _user.name ?? "N/A",
                  key: "Flight Name",
                ),
                Divider(),
                textCard(
                  context: context,
                  value: _user.name ?? "N/A",
                  key: "Flight Number",
                ),
                Divider()
              ],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                width: MediaQuery.of(context).size.width,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        color: Colors.blueAccent,
                        child: Row(
                          children: const <Widget>[
                            Text(
                              "OK",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 5.0),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]),
              )
            ],
          );
        });
  }

  _showHotelDetails(context) {
    final _user = ref.watch(payStateProvider).user;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Flight Details",
                //   style: GoogleFonts.inter(
                //     color: Constants.kPrimaryColor,
                //     fontSize: 16,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                // Divider(
                //   height: 20,
                //   color: Constants.kPrimaryColor,
                // ),

                textCard(
                  context: context,
                  value: _user.name ?? "N/A",
                  key: "Hotel Name",
                ),
                Divider(),
                textCard(
                  context: context,
                  value: _user.name ?? "N/A",
                  key: "Hotel Rank",
                ),
                Divider(),
                textCard(
                  context: context,
                  value: _user.name ?? "N/A",
                  key: "Location",
                ),
                Divider(),
                textCard(
                  context: context,
                  value: _user.name ?? "N/A",
                  key: "Room Number",
                ),
                Divider(),
                textCard(
                  context: context,
                  value:
                      _user.name ?? "N/A",
                  key: "Allocated Number of Days",
                ),
                Divider(),
                textCard(
                  context: context,
                  value: _user.name ?? "N/A",
                  key: "Meal Details",
                ),
                Divider(),
                textCard(
                  context: context,
                  value: _user.name ?? "N/A",
                  key: "Price Rate",
                ),
                Divider(),
              ],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                width: MediaQuery.of(context).size.width,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        color: Colors.blueAccent,
                        child: Row(
                          children: const <Widget>[
                            Text(
                              "OK",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 5.0),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]),
              )
            ],
          );
        });
  }

  _showWifiDetails(context) {
    final _user = ref.watch(payStateProvider).user;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textCard(
                  context: context,
                  value: "Wifi Name",
                  key: "WIFI NAME",
                ),
                Divider(),
                textCard(
                  context: context,
                  value: "PASSWORD123",
                  key: "PASSWORD",
                ),
                Divider(),
              ],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                width: MediaQuery.of(context).size.width,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        color: Colors.blueAccent,
                        child: Row(
                          children: const <Widget>[
                            Text(
                              "OK",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 5.0),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]),
              )
            ],
          );
        });
  }

  void _showQRCodeDialog() {
    final _user = ref.watch(payStateProvider).user;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BarcodeWidget(
                barcode: Barcode.qrCode(),
                color: Colors.black,
                data: _user.name!,
                height: 200,
                width: 200,
              )
            ],
          ),
        );
      },
    );
  }
}