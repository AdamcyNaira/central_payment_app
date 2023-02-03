import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:io' as io;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:result_verification/model/user_model.dart';
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
  String id = "1";
  String saveUser = "";


  patientRegistration() async {
    //Save event list in local Storage
    List<Users> _users= [];
    String fileName = "usersList.json";
    var dir = await getTemporaryDirectory();
    File file =  File(dir.path + "/" + fileName);
    var syncDirectory = await file;
    await io.File(syncDirectory.toString()).exists();
    bool checkFile = io.File(syncDirectory.toString()).existsSync();
    if (!checkFile) {
      _users.add(Users.fromJson({
           "name": '',
           "email": '',
           "phone": '',
           "password": '',
           "id": '1',
        }));
          file.writeAsStringSync(json.encode(_users), flush: true, mode: FileMode.write);
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

        getData();

        var jsonData = file.readAsStringSync();
        List localData = json.decode(jsonData);
        localData.map((items) => _users.add(Users.fromJson(items))).toList();

       List<Users> check = _users.where((item)=> item.email == email || item.phone == phone).toList();
        print(check.map((e) => print(e.name)));
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
         _users.add(Users.fromJson(userData));

          //SAVE USER DETAILS IN LOCAL STORAGE
          //Write users list in local Storage
          file.writeAsStringSync(json.encode(_users), flush: true, mode: FileMode.write);
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
          // clearRegistrationForm();
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
                        color: Constants.kIconsColor,
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
                                const EdgeInsets.only(left: 20.0, right: 15.0),
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
                        iconColor: Constants.kIconsColor,
                        hintText: 'Password',
                        suffixIconVisibility: Icons.visibility,
                        suffixIconVisibilityOff: Icons.visibility_off,
                        suffixIconColor:
                            Constants.kIconsColor.withOpacity(0.6),
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
                          color: Constants.kIconsColor.withOpacity(0.8),
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