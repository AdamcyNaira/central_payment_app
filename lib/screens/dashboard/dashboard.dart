import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:result_verification/widgets/card_widget.dart';

import '../../util/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.kBackgroundColor,
        body:  Container(
              height: screenHeight(context),
              width: screenWidth(context),
              child: RefreshIndicator(
                onRefresh: () async => {
               //  await ref.watch(eventListState.future),
                },
                child: ListView(
                  children: [
                    Container(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    height: screenHeight(context) * 0.45,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: Constants.kBlackColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DashboardTop(),
                        YMargin(20),
                         DashboardCard(),
                      YMargin(30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, "/payment_types"),
                            child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                        child: Text(
                            "Make Payment",
                            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                      ),
                          ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0XFFfec52d),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                        child: Text(
                          "Transactions",
                          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                      ),
                        ],
                      )
                      
                      ],
                    ),
                  ),
                    YMargin(30),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent Transactions",
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Constants.kTextColor,
                            ),
                          ),
                           Container(
                          decoration: BoxDecoration(
                            color: Constants.kGreyColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(
                            "View All",
                            style: TextStyle(color: Colors.white60, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ],
                      ),
                    ),
                    YMargin(30), 
                    TransactionTile(
                      icon: Ionicons.wallet_outline,
                      title: "Result Procession Fee",
                      subTitle: "22, December, 2022",
                      amount: "5,000",
                    ),
                    TransactionTile(
                      icon: Ionicons.wallet_outline,
                      title: "Tuition Fee",
                      subTitle: "01, January, 2023",
                      amount: "85,000",
                    ),
                    TransactionTile(
                      icon: Ionicons.wallet_outline,
                      title: "Result Verification Fee",
                      subTitle: "04, January, 2023",
                      amount: "5,000",
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}




class BottomNav extends ConsumerStatefulWidget {
  BottomNav({super.key});

  @override
  _BottomNavState createState() =>
      _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {
  _BottomNavState();

  int _selectedIndex = 0;
  final menu = [
    const Dashboard(),
    const Dashboard(),
    const Dashboard(),
    const Dashboard(),
  ];
   void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: menu.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.home_outline,
              size: 15.0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.cash_outline,
              size: 15.0,
            ),
            label: 'Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.list_outline,
              size: 15.0,
            ),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.person_circle_outline,
              size: 15.0,
            ),
            label: 'Account',
          ),
        ],
        showUnselectedLabels: true,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.black54,
        selectedIconTheme:  IconThemeData(color: Colors.black, opacity: 1, size: 20),
        unselectedIconTheme:  IconThemeData(color: Colors.black, opacity: 0.5),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        elevation: 8,
        backgroundColor: Constants.kWhiteColor,
      ),
    );
  }
}

class DashboardTop extends ConsumerStatefulWidget {
  const DashboardTop({Key? key}) : super(key: key);

  @override
  _DashboardTopState createState() => _DashboardTopState();
}

class _DashboardTopState extends ConsumerState<DashboardTop> {
  var photo = "";
  var name = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      photo = "";
      name = "Adam Musa Yau";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 244, 242, 242),
                  image: photo.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(
                            photo,
                          ),
                          fit: BoxFit.fill,
                        )
                      : DecorationImage(
                          image: AssetImage(
                            'assets/images/placeholder.png',
                          ),
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            ),
            const XMargin(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Constants.kGreyColor,
                  ),
                ),
                const YMargin(1),
                Text(
                  "How are you doing today?",
                  style: GoogleFonts.openSans(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            height: 40,
            width: 40,
            color: Color.fromARGB(255, 48, 48, 48),
            child: Icon(Ionicons.notifications_outline, color: Constants.kGreyColor,),
          ),
        ),
      ],
    );
  }
}
