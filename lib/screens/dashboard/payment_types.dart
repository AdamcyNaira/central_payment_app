import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:result_verification/model/payment_model.dart';
import 'package:result_verification/providers/payent_state.dart';
import 'package:result_verification/util/constants.dart';
import 'package:result_verification/widgets/card_widget.dart';
import 'package:result_verification/widgets/dashboard_widget.dart';
import 'package:string_2_icon/string_2_icon.dart';
import '../../widgets/menu_widet.dart';

class PaymentTypes extends ConsumerStatefulWidget {
  const PaymentTypes({super.key});

  @override
  ConsumerState<PaymentTypes> createState() => _PaymentTypesState();
}

class _PaymentTypesState extends ConsumerState<PaymentTypes> {

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
        banner: "assets/images/payment.jpg",
        caption: "Choose Payment"
        ), preferredSize: Size.fromHeight(200),
      ), 
      body: Container(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
        children: [
          GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.3,
                padding: const EdgeInsets.all(0.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 10.0,
                shrinkWrap: true,
                primary: false,
                children: [
                  PaymentMenuCard(
                    title: "Tuition",
                    icon: Ionicons.cash_outline,
                    route: () {
                     
                      final invoice = Payment.fromJson({
                        "id": "1",
                        "userId": _user.id.toString(),
                        "paymentType": "Tuition Fee",
                        "Amount": "45500",
                        "paymentID": "001",
                        "date": "2023-03-01",
                        "status": "Pending",
                        "orderID": "123456789",
                      });
                  
                      ref.read(payStateProvider).setInvoice(invoice);
                      Navigator.pushNamed(context, "/payment_review");
                    },
                  ),
                  PaymentMenuCard(
                    title: "Application",
                    icon: Icons.edit_note_outlined,
                    route: () {
                      
                      final invoice = Payment.fromJson({
                        "id": "2",
                        "userId": _user.id.toString(),
                        "paymentType": "Application Fee",
                        "Amount": "5000",
                        "paymentID": "002",
                        "date": "2023-03-01",
                        "status": "Pending",
                        "orderID": "123456789",
                      });
                  
                      ref.read(payStateProvider).setInvoice(invoice);
                      Navigator.pushNamed(context, "/payment_review");
                    },
                  ),
                   PaymentMenuCard(
                    title: "Course",
                    icon: Ionicons.book_outline,
                    route: () {
                      
                      final invoice = Payment.fromJson({
                        "id": "3",
                        "userId": _user.id.toString(),
                        "paymentType": "Course Fee",
                        "Amount": "15000",
                        "paymentID": "003",
                        "date": "2023-03-01",
                        "status": "Pending",
                        "orderID": "123456789",
                      });
                  
                      ref.read(payStateProvider).setInvoice(invoice);
                      Navigator.pushNamed(context, "/payment_review");
                    },
                  ),
                   PaymentMenuCard(
                    title: "Hostel",
                    icon: Icons.home_sharp,
                    route: () {
                      
                      final invoice = Payment.fromJson({
                        "id": "4",
                        "userId": _user.id.toString(),
                        "paymentType": "Hostel Fee",
                        "Amount": "20500",
                        "paymentID": "004",
                        "date": "2023-03-01",
                        "status": "Pending",
                        "orderID": "123456789",
                      });
                  
                      ref.read(payStateProvider).setInvoice(invoice);
                      Navigator.pushNamed(context, "/payment_review");
                    },
                  ),
                   PaymentMenuCard(
                    title: " Original Result Processing",
                    icon: Icons.file_copy,
                    route: () {
                      
                      final invoice = Payment.fromJson({
                        "id": "5",
                        "userId": _user.id.toString(),
                        "paymentType": "Original Result Processing Fee",
                        "Amount": "5000",
                        "paymentID": "005",
                        "date": "2023-03-01",
                        "status": "Pending",
                        "orderID": "123456789",
                      });
                  
                      ref.read(payStateProvider).setInvoice(invoice);
                      Navigator.pushNamed(context, "/payment_review");
                    },
                  ),
                   PaymentMenuCard(
                    title: "Transcript Processing",
                    icon: Icons.file_open,
                    route: () {
                      
                      final invoice = Payment.fromJson({
                        "id": "6",
                        "userId": _user.id.toString(),
                        "paymentType": "Transcript Processing Fee",
                        "Amount": "5500",
                        "paymentID": "006",
                        "date": "2023-03-01",
                        "status": "Pending",
                        "orderID": "123456789",
                      });
                  
                      ref.read(payStateProvider).setInvoice(invoice);
                      Navigator.pushNamed(context, "/payment_review");
                    },
                  ),
                  PaymentMenuCard(
                    title: "Miscellaneous",
                    icon: Icons.link_outlined,
                    route: () {
                      
                      final invoice = Payment.fromJson({
                        "id": "7",
                        "userId": _user.id.toString(),
                        "paymentType": "Miscellaneous Fee",
                        "Amount": "10000",
                        "paymentID": "007",
                        "date": "2023-03-01",
                        "status": "Pending",
                        "orderID": "123456789",
                      });
                  
                      ref.read(payStateProvider).setInvoice(invoice);
                      Navigator.pushNamed(context, "/payment_review");
                    },
                  ),
                ]),
        
        ],
      ),
      ),
    );
  }
}
