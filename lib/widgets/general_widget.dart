import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import '../util/constants.dart';

void showInternetError({
  context,
  msg,
}) {
  CoolAlert.show(
    context: context,
    type: CoolAlertType.warning,
    title: 'NETWORK ERROR',
    text: msg,
    loopAnimation: true,
    backgroundColor: Constants.kPrimaryColor,
  );
}

void showSuccessDialog({
  context,
  msg,
  title,
  Function()? route,
}) {
  CoolAlert.show(
    context: context,
    type: CoolAlertType.success,
    text: msg,
    loopAnimation: false,
    confirmBtnColor: Constants.kPrimaryColor,
    barrierDismissible: false,
    title: "",
    backgroundColor: Constants.kPrimaryColor,
    onConfirmBtnTap: route!,
  );
}

void showSuccessDialogAppointment({context, msg, title, Function()? route}) {
  CoolAlert.show(
    context: context,
    type: CoolAlertType.success,
    text: msg,
    loopAnimation: false,
    title: "",
    backgroundColor: Constants.kPrimaryColor,
    barrierDismissible: false,
    onConfirmBtnTap: route!,
  );
}

void showErrorDialog({
  context,
  msg,
  title,
}) {
  CoolAlert.show(
    context: context,
    type: CoolAlertType.error,
    title: title,
    text: msg,
    loopAnimation: false,
    barrierDismissible: false,
    confirmBtnColor: Constants.kIconsColor,
    backgroundColor: Constants.kIconsColor,
  );
}

void showLoadingDialog(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        content: Row(
          children: const <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              width: 25.0,
            ),
            Text("Please wait..."),
          ],
        ),
      );
    },
  );
}

void showConfrimDialog({context, msg, title, route}) {
  CoolAlert.show(
    context: context,
    type: CoolAlertType.confirm,
    onConfirmBtnTap: route,
    text: msg,
    loopAnimation: false,
    title: "",
    backgroundColor: Constants.kPrimaryColor,
  );
}
