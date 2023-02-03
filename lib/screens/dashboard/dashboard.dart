import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:result_verification/widgets/card_widget.dart';

import '../../model/payment_model.dart';
import '../../providers/payent_state.dart';
import '../../util/constants.dart';
import 'payment_types.dart';
import 'user_account.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
   // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle( statusBarColor: Constants.kBlackColor, statusBarBrightness: Brightness.light));
   final user = ref.read(payStateProvider).user;
    List<Payment> _payments = ref.watch(payStateProvider).payments.where((element) => element.userId == user.id).toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.kBackgroundColor,
        body:  Container(
              height: screenHeight(context),
              width: screenWidth(context),
              child: RefreshIndicator(
                onRefresh: () async => {
                 // Constants.sharedPref!.clear()
               //  await ref.watch(eventListState.future),
                },
                child: ListView(
                  shrinkWrap: true,
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
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        child: Text(
                            "Make Payment",
                            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                      ),
                          ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "/verify_certificate"),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFfec52d),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          child: Text(
                            "Verify Certificate",
                            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                          ),
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
                    YMargin(20), 
                    _payments.length > 0 ?
                     ListView.builder(
                      shrinkWrap: true,
                      primary: false,
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
    const PaymentTypes(),
    const UserAccount(),
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
    final user = ref.read(payStateProvider).user;
    super.initState();
    setState(() {
      photo = "";
      name = user.name!;
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
