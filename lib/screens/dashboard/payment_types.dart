import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:result_verification/util/constants.dart';
import 'package:result_verification/widgets/card_widget.dart';
import 'package:result_verification/widgets/dashboard_widget.dart';
import 'package:string_2_icon/string_2_icon.dart';
import '../../widgets/menu_widet.dart';

class PaymentTypes extends StatefulWidget {
  const PaymentTypes({super.key});

  @override
  State<PaymentTypes> createState() => _PaymentTypesState();
}

class _PaymentTypesState extends State<PaymentTypes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kBackgroundColor,
      appBar:  twoButtonsAppbar(
        context: context,
        icon1: Icons.arrow_back_ios_new,
        route1: () => Navigator.of(context).pop(),
        title: "Payments",
      ),
      body: Container(
              padding: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
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
                    route: ()=>Navigator.pushNamed(context, "/payment_review"),
                  ),
                  PaymentMenuCard(
                    title: "Application",
                    icon: Icons.edit_note_outlined,
                    route: ()=>Navigator.pushNamed(context, "/"),
                  ),
                   PaymentMenuCard(
                    title: "Course",
                    icon: Ionicons.book_outline,
                    route: ()=>Navigator.pushNamed(context, "/"),
                  ),
                   PaymentMenuCard(
                    title: "Hostel",
                    icon: Icons.home_sharp,
                    route: ()=>Navigator.pushNamed(context, "/"),
                  ),
                   PaymentMenuCard(
                    title: " Original Result Processing",
                    icon: Icons.file_copy,
                    route: ()=>Navigator.pushNamed(context, "/"),
                  ),
                   PaymentMenuCard(
                    title: "Transcript Processing",
                    icon: Icons.file_open,
                    route: ()=>Navigator.pushNamed(context, "/"),
                  ),
                  PaymentMenuCard(
                    title: "Miscellaneous",
                    icon: Icons.link_outlined,
                    route: ()=>Navigator.pushNamed(context, "/"),
                  ),
                ]),
        
        ],
      ),
      ),
    );
  }
}
