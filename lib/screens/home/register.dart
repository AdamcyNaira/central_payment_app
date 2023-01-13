import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';

import '../../util/constants.dart';
import '../../widgets/form_widget.dart';
import '../../widgets/general_widget.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String name = "";
  String email = "";
  String phone = "";
  String password = "";
  String id = "";
  String saveUser = "";


  patientRegistration() async {
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

        getData();

       final user = jsonDecode(usersModel ?? jsonEncode([{"email": "", "phone": ""}]));
        print(user);
       final check = user.where((item)=> item["email"] == email || item["phone"] == phone).toList();
        print(check);
        if (check.length > 0) {
          setState(() {
            saveUser = "exist";
          });
        }else{
            setState(() {
            saveUser = "success";
          });
        }


        if (saveUser == "success") {
           final userData = {
           "name": name,
           "email": email,
           "phone": phone,
           "password": password,
           "id": id,
        };

          //SAVE USER DETAILS IN LOCAL STORAGE
          setState(() {
            Constants.sharedPref!
                .setString("userID", id.toString());
            Constants.sharedPref!.setString(
                "name", name.toString());
            Constants.sharedPref!.setString(
                "password", password.toString());
            Constants.sharedPref!
                .setString("email", email.toString());
            Constants.sharedPref!.setString(
                "phone", phone.toString());
            Constants.sharedPref!
                .setString("userModel", jsonEncode(userData));
            Constants.sharedPref!
                .setString("usersModel", jsonEncode(user.add(userData)));
            Constants.sharedPref!.setBool("isLoggedIn", true);
            isLoading = false;
          });
          setState(() {
            isLoading = false;
          });
          isLoading
              ? showLoadingDialog(context)
              : Navigator.of(context, rootNavigator: true).pop('dialog');
          showSuccessDialog(
            context: context,
            msg:
                "Registration Successfully! Kindly use your email and password to login",
            route: () => Navigator.pushReplacementNamed(context, '/login'),
          );
          clearRegistrationForm();
        } else if (saveUser == "exist") {
          setState(() {
            isLoading = false;
          });
          isLoading
              ? showLoadingDialog(context)
              : Navigator.of(context, rootNavigator: true).pop('dialog');
          showErrorDialog(
              context: context, msg: "User already exist!", title: "Oops!");
        } else {
          setState(() {
            isLoading = false;
          });
          isLoading
              ? showLoadingDialog(context)
              : Navigator.of(context, rootNavigator: true).pop('dialog');
          showErrorDialog(
              context: context,
              msg: "Something went wrong with your registration",
              title: "Oops!");
        }
      } else {
        showInternetError();
      }
    }
  }

  void clearRegistrationForm() {
    titleController.clear();
    nameController.clear();
    passwordController.clear();
    emailController.clear();
    phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Constants.kPrimaryColor.withOpacity(0.01),
        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        height: screenHeight(context),
        width: screenWidth(context),
        child: SingleChildScrollView(
          primary: false,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const YMargin(100),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: Constants.kPrimaryColor.withOpacity(0.8),
                        fontFamily: 'Quando',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const YMargin(15),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Easily Create an Account',
                    style: TextStyle(
                      color: Colors.black38,
                      fontFamily: 'raleway',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const YMargin(30),
                
                 inputLabel(title: 'Name'),
                          build2TextInput(
                            controller: nameController,
                            onSave: (val) {
                                  setState(() {
                                    name = val!;
                                  });
                            } ,
                            onChanged: (val){
                              setState(() {
                                    name = val!;
                                  });
                            },
                            validator: (val) => val!.isEmpty
                                ? 'Please enter your name'
                                : null,
                            keyboardType: TextInputType.text,
                            hintText: 'Name',
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 0.0),
                          ),
                const YMargin(10),
                inputLabel(title: 'Email Address'),
                buildTextInput(
                  controller: emailController,
                   onSave: (val) {
                                  setState(() {
                                    email = val!;
                                  });
                            } ,
                            onChanged: (val){
                              setState(() {
                                    email = val!;
                                  });
                            },
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter your email address' : null,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'user@example.com',
                ),
                inputLabel(title: 'Phone Number'),
                buildTextInput(
                  controller: phoneController,
                   onSave: (val) {
                                  setState(() {
                                    phone = val!;
                                  });
                            } ,
                            onChanged: (val){
                              setState(() {
                                    phone = val!;
                                  });
                            },
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter your phone number' : null,
                  keyboardType: TextInputType.number,
                  hintText: '080XXXXXXXXX',
                ),
                 const YMargin(10),
                      PasswordInpute(
                        controller: passwordController,
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
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                  // ignore: deprecated_member_use
                  child: MaterialButton(
                    color: Constants.kIconsColor,
                    child: const Text(
                      'SIGNUP',
                      style: TextStyle(fontSize: 14),
                    ),
                    shape: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Constants.kIconsColor, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(15),
                    textColor: Colors.white,
                    onPressed: patientRegistration,
                  ),
                ),
                const YMargin(20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Colors.black38,
                      ),
                    ),
                    const XMargin(5),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Login',
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
          ),
        ),
      ),
    );
  }
}