import 'package:flutter/material.dart';

class PaymentState extends ChangeNotifier {
  //GETTERS
  Map<String, dynamic> user = {};
  List payments = [];
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

  //SETTERS
void setUser(value) {
  user = value;
  notifyListeners();
}

void setPayments(value) {
  payments = value;
  notifyListeners();
}

}
