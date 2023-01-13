import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static SharedPreferences? sharedPref;
  static const kTextColor = Color(0XFF545559);
  static const kMediumTextColor = Color(0XFF53627C);
  static const kLightColor = Color(0XFFACB1C0);
  static const kPrimaryColor = Color.fromARGB(255, 67, 143, 74);
  static const kFormFillColor = Color(0XFFfdfff5);
  final kPrimaryColorOpacity = Color(0xff008080).withOpacity(0.8);
  static const kPrimaryColor2 = Color(0xff123318);
  static const kBackgroundColor = Color(0xFFf1f3f4);
  static const kWhiteColor = Color(0xFFffffff);
  static const kGreyColor = Color(0xFFa0a5b1);
  static const kLightGreyColor = Color(0xFFf1f3f4);
  static const kBlackColor = Color(0xFF22272e);
  static const kBlueColor = Color(0xFF2C53B1);
  static const kTitleColor = Color(0xFF23374D);
  static const kSubtitleColor = Color(0xFF8E8E8E);
  static const kBorderColor = Color(0xFFE8E8F3);
  static const kFillColor = Color(0xFFFFFFFF);
  static const kCardTitleColor = Color(0xFF2E4ECF);
  static const kIconsColor = Color(0XFF425b5e);
  static const kCardSubtitleColor = kTitleColor;
  static const kSecondaryColor = Color.fromARGB(255, 244, 242, 242);

  static Future<bool> saveImageToSharedPref(String value) async {
    sharedPref = await SharedPreferences.getInstance();
    return sharedPref!.setString("key", value);
  }

  static Future<String> getImageFromPref() async {
    sharedPref = await SharedPreferences.getInstance();
    return sharedPref!.getString("key")!;
  }

  static String base64Sring(Uint8List data) {
    return base64Encode(data);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }
}

class XMargin extends StatelessWidget {
  final double x;
  const XMargin(this.x);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: x);
  }
}

class YMargin extends StatelessWidget {
  final double y;
  const YMargin(this.y);
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: y);
  }
}

//SCREEN SIZE
double screenHeight(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.height * percent;

double screenWidth(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.width * percent;

// Style for title
var mTitleStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w600, color: Constants.kTitleColor, fontSize: 13);

// Style for title
var kNoRecordFoundStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w600, color: Colors.black54, fontSize: 13);

// Style for title
var kNairaStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w600, color: Colors.white60, fontSize: 20);

// Style for title
var mScheduleTimeStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w600, color: Constants.kTitleColor, fontSize: 11);

// Style for subTitle
var mSubTitleStyle = GoogleFonts.inter(
    color: Constants.kTitleColor.withOpacity(0.6), fontSize: 12);

// Style for subTitle
var ktransAmountStyle = GoogleFonts.inter(
  color: Constants.kTitleColor.withOpacity(0.6),
  fontSize: 12,
  fontWeight: FontWeight.bold,
);

// Style for Home Section
var kBoldText = GoogleFonts.inter(
    fontSize: 14, fontWeight: FontWeight.w700, color: Constants.kPrimaryColor);

var kWalletText = GoogleFonts.inter(
    fontSize: 18, fontWeight: FontWeight.w700, color: Constants.kPrimaryColor);

var kWalletAmountText = GoogleFonts.inter(
    fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black54);

// Style for About Section
TextStyle homeTextStyle = GoogleFonts.raleway(
    fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54);

var mServiceSubtitleStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w400, fontSize: 10, color: Constants.kSubtitleColor);

String? userID;
String? userFirstName;
String? userLastName;
String? userName;
String? userEmail;
String? userPhone;
String? userPassword;
String? userModel;
String? usersModel = "";
String? usersPayment;
String? token;
bool? isLoggedIn = false;

getData() {
  userEmail = Constants.sharedPref!.getString("email");
  userPhone = Constants.sharedPref!.getString("phone");
  userName = Constants.sharedPref!.getString("name");
  userID = Constants.sharedPref!.getString("userID");
  userPassword = Constants.sharedPref!.getString("password");
  userModel = Constants.sharedPref!.getString("userModel");
  usersModel = Constants.sharedPref!.getString("usersModel");
  usersPayment = Constants.sharedPref!.getString("usersPayment");
  token = Constants.sharedPref!.getString("token");
  isLoggedIn = Constants.sharedPref!.getBool("isLoggedIn");
}

var spinKitRing = const SpinKitDualRing(
  color: Colors.black54,
  size: 15.0, 
);

String status = "Live";
String serverLink = status == "Dev"
    ? "http://localhost:4480"
    : "https://assembly.pythonanywhere.com";

var header = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'JWT $token',
};

dateFormater(date, format) {
  final DateTime now = date != null ? DateTime.parse(date) : DateTime.now();
  final DateFormat formatter =
      format != null ? DateFormat(format) : DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  return formatted;

//   ICU Name                   Skeleton
// --------                   --------
// DAY                          d
// ABBR_WEEKDAY                 E
// WEEKDAY                      EEEE
// ABBR_STANDALONE_MONTH        LLL
// STANDALONE_MONTH             LLLL
// NUM_MONTH                    M
// NUM_MONTH_DAY                Md
// NUM_MONTH_WEEKDAY_DAY        MEd
// ABBR_MONTH                   MMM
// ABBR_MONTH_DAY               MMMd
// ABBR_MONTH_WEEKDAY_DAY       MMMEd
// MONTH                        MMMM
// MONTH_DAY                    MMMMd
// MONTH_WEEKDAY_DAY            MMMMEEEEd
// ABBR_QUARTER                 QQQ
// QUARTER                      QQQQ
// YEAR                         y
// YEAR_NUM_MONTH               yM
// YEAR_NUM_MONTH_DAY           yMd
// YEAR_NUM_MONTH_WEEKDAY_DAY   yMEd
// YEAR_ABBR_MONTH              yMMM
// YEAR_ABBR_MONTH_DAY          yMMMd
// YEAR_ABBR_MONTH_WEEKDAY_DAY  yMMMEd
// YEAR_MONTH                   yMMMM
// YEAR_MONTH_DAY               yMMMMd
// YEAR_MONTH_WEEKDAY_DAY       yMMMMEEEEd
// YEAR_ABBR_QUARTER            yQQQ
// YEAR_QUARTER                 yQQQQ
// HOUR24                       H
// HOUR24_MINUTE                Hm
// HOUR24_MINUTE_SECOND         Hms
// HOUR                         j
// HOUR_MINUTE                  jm
// HOUR_MINUTE_SECOND           jms
// HOUR_MINUTE_GENERIC_TZ       jmv
// HOUR_MINUTE_TZ               jmz
// HOUR_GENERIC_TZ              jv
// HOUR_TZ                      jz
// MINUTE                       m
// MINUTE_SECOND                ms
// SECOND                       s
}


  List payment_types = [{
    "title": "Tuition",
    "icon": "Ionicons.cash_outline",
  },
  {
    "title": "Application",
    "icon": "Icons.edit_note_outlined",
  },
  {
    "title": "Course",
    "icon": "Ionicons.book_outline",
  },
  {
    "title": "Hostel",
    "icon": "Icons.home_sharp",
  },
  {
    "title": "Original Result Processing",
    "icon": "Icons.file_copy",
  },
   {
    "title": "Transcript Processing",
    "icon": "Icons.file_open",
  },
  {
    "title": "Miscellaneous",
    "icon": "Icons.link_outlined",
  }
  ];