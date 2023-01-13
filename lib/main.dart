import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:result_verification/screens/dashboard/dashboard.dart';
import 'package:result_verification/screens/dashboard/payment_review.dart';
import 'package:result_verification/screens/dashboard/payment_types.dart';
import 'package:result_verification/screens/home/login.dart';
import 'package:result_verification/screens/home/register.dart';
import 'package:result_verification/screens/home/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'util/constants.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.sharedPref = await SharedPreferences.getInstance();
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Central Payment System(CPS)',
      theme: ThemeData(
        primaryColor: Constants.kIconsColor,
        colorScheme: ColorScheme.light(),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
       routes: {
        // '/registration': (ctx) => const Registration(),
        '/register': (ctx) => const Registration(),
        '/login': (ctx) => const Login(),
        '/dashboard': (ctx) => BottomNav(),
        '/payment_types': (ctx) => PaymentTypes(),
        '/payment_review': (ctx) => PaymentReview(),
      },
    );
  }
}
