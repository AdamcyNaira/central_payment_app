import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity/connectivity.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/payment_model.dart';
import '../../model/user_model.dart';
import '../../providers/payent_state.dart';
import '../../util/constants.dart';
import '../../widgets/dashboard_widget.dart';
import '../../widgets/form_widget.dart';
import '../../widgets/general_widget.dart';
import 'dart:io' as io;

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  TextEditingController emaill = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool isLoading = false;
  bool? isLoggedIn = false;
  String password = '';
  String username = '';
  String loginResponse = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  userLogin() async {
      List<Users> _users= [];
      List<Payment> _payments = [];
    String fileName = "usersList.json";
    String paymentFileName = "paymentsList.json";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    File paymentFile = File(dir.path + "/" + paymentFileName);
    if (file.path.isEmpty) {
      file.writeAsStringSync(json.encode([]), flush: true, mode: FileMode.write);
    }
    
    
    if (formKey.currentState!.validate()) {
      var result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        formKey.currentState!.save();
        setState(() {
          isLoading = true;
        });
        isLoading
            ? showLoadingDialog(context)
            : Navigator.of(context, rootNavigator: true).pop('dialog');
        Timer(const Duration(seconds: 3), () {});

        var jsonData = file.readAsStringSync();
        List localData = json.decode(jsonData);
        localData.map((items) => _users.add(Users.fromJson(items))).toList();

       List<Users> check = _users.where((item)=> item.email == username || item.password == password).toList();
        
        if (check.length > 0) {
          setState(() {
            loginResponse = "success";
          });
        }else{
            setState(() {
            loginResponse = "invalid";
          });
        }

        if (loginResponse == "success") {
          //SAVE USER DETAILS IN LOCAL STORAGE
          setState(() {
            Constants.sharedPref!
                .setString("userModel", jsonEncode(check[0]));
            Constants.sharedPref!.setBool("isLoggedIn", true);
            isLoading = false;
          });

           var syncDirectory = await paymentFile;
        await io.File(syncDirectory.toString()).exists();
        bool checkFile = io.File(syncDirectory.toString()).existsSync();
        if (!checkFile) {
          _payments.add(Payment.fromJson({
                        "id": '100000000000',
                        "userId": '',
                        "paymentType": '',
                        "Amount": '',
                        "paymentID": '',
                        "date": DateTime.now().toString(),
                        "status": "",
                        "orderID": '',
                      }));
              paymentFile.writeAsStringSync(json.encode(_payments), flush: true, mode: FileMode.write);
        }

          var paymetJsonData = paymentFile.readAsStringSync();
          List localPaymentData = json.decode(paymetJsonData);
          localPaymentData.where((element) => element["userID"] ==  check[0].id).map((items) => _payments.add(Payment.fromJson(items))).toList();

          ref.read(payStateProvider).setUser(check[0]);
          ref.read(payStateProvider).setPayments(_payments);
          getData();

          isLoading
              ? showLoadingDialog(context)
              : Navigator.of(context, rootNavigator: true).pop('dialog');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Login Successful'),
            onVisible: () {
              Timer(const Duration(seconds: 2), () {
                Future.delayed(Duration.zero, () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/dashboard', (route) => false);
                });
              });
            },
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.black87,
          ));
        } else if (loginResponse == "invalid") {
          setState(() {
            isLoading = false;
          });
          isLoading
              ? showLoadingDialog(context)
              : Navigator.of(context, rootNavigator: true).pop('dialog');
          showErrorDialog(
              context: context,
              msg: "Invalid Login Credential!",
              title: "Oops!");
        } else {
          setState(() {
            isLoading = false;
          });
          isLoading
              ? showLoadingDialog(context)
              : Navigator.of(context, rootNavigator: true).pop('dialog');
          showErrorDialog(
              context: context, msg: "Something went wrong", title: "Oops!");
        }
      } else {
        showInternetError();
      }
    }
  }

  checkLoginState() async{
    List<Payment> _payments = [];
    String paymentFileName = "paymentsList.json";
    var dir = await getTemporaryDirectory();
    File paymentFile = File(dir.path + "/" + paymentFileName);

    if (isLoggedIn == true) {
      Future.delayed(Duration.zero, () async{
        Users userData = Users.fromJson(json.decode(userModel ?? ""));

        var syncDirectory = await paymentFile;
        await io.File(syncDirectory.toString()).exists();
        bool checkFile = io.File(syncDirectory.toString()).existsSync();
        print(syncDirectory.existsSync());
        if (!syncDirectory.existsSync()) {
          _payments.add(Payment.fromJson({
                        "id": '1000000000003',
                        "userId": '',
                        "paymentType": '',
                        "Amount": '',
                        "paymentID": '',
                        "date": DateTime.now().toString(),
                        "status": "",
                        "orderID": '',
                      }));
              paymentFile.writeAsStringSync(json.encode(_payments), flush: true, mode: FileMode.write);
        }

        var paymetJsonData = paymentFile.readAsStringSync();
          List localPaymentData = json.decode(paymetJsonData);
          print(localPaymentData);
          localPaymentData.where((element) => element["userID"] ==  userData.id).map((items) => _payments.add(Payment.fromJson(items))).toList();

        ref.read(payStateProvider).setUser(userData);
        ref.read(payStateProvider).setPayments(_payments);
        Navigator.pushNamedAndRemoveUntil(
            context, '/dashboard', (route) => false);
      });
    }
  }

  getData() {
    setState(() {
      userID = Constants.sharedPref!.getString("userID");
      userModel = Constants.sharedPref!.getString("userModel");
      token = Constants.sharedPref!.getString("token");
      isLoggedIn = Constants.sharedPref!.getBool("isLoggedIn");
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    checkLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          height: screenHeight(context),
          width: screenWidth(context),
          child: SingleChildScrollView(
            primary: false,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hello Again!",
                            style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                color: Constants.kTextColor),
                            textAlign: TextAlign.center,
                          ),
                          YMargin(10),
                          Text(
                            "Welcome back you've \n been missed!",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          YMargin(30),
                        ]),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      usernameInput(
                        controller: emaill,
                        onSave: (val) {
                          setState(() {
                            username = val!;
                          });
                        },
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter your username' : null,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
                        prefixIcon: Icons.person,
                        iconColor: Constants.kPrimaryColor.withOpacity(0.6),
                        hintText: 'Enter username',
                      ),
                      const YMargin(30),
                      PasswordInpute(
                        controller: pass,
                        onSave: (val) {
                          setState(() {
                            password = val!;
                          });
                        },
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter your password' : null,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
                        prefixIcon: Icons.lock,
                        iconColor: Constants.kPrimaryColor.withOpacity(0.6),
                        hintText: 'Password',
                        suffixIconVisibility: Icons.visibility,
                        suffixIconVisibilityOff: Icons.visibility_off,
                        suffixIconColor:
                            Constants.kPrimaryColor.withOpacity(0.6),
                      ),
                      const YMargin(30),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 15.0),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.end,
                      //     children: [
                      //       InkWell(
                      //         onTap: () async {},
                      //         child: Text(
                      //           ' Password Recovery',
                      //           style: TextStyle(
                      //             fontFamily: 'Roboto',
                      //             fontSize: 12,
                      //             color:
                      //                 Constants.kPrimaryColor.withOpacity(0.8),
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //           textAlign: TextAlign.right,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const YMargin(30),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                        // ignore: deprecated_member_use
                        child: MaterialButton(
                          color: Constants.kPrimaryColor.withOpacity(0.8),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 14),
                          ),
                          shape: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Constants.kPrimaryColor, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(20),
                          textColor: Colors.white,
                          onPressed: () {
                            userLogin();
                          },
                        ),
                      ),
                      const YMargin(50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Constants.kPrimaryColor.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text("Or continue with "),
                          ),
                          Expanded(
                            child: Divider(
                              color: Constants.kPrimaryColor.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            chooseMenu(
                              title: "",
                              img: "assets/images/google.png",
                              route: () {},
                            ),
                            chooseMenu(
                              title: "",
                              img: "assets/images/apple.png",
                              route: () {},
                            ),
                            chooseMenu(
                              title: "",
                              img: "assets/images/facebook.jpeg",
                              route: () {},
                            ),
                          ],
                        ),
                      ),
                      const YMargin(20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          ),
                          const XMargin(5),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text(
                              'register',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Constants.kPrimaryColor.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
