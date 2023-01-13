import 'dart:convert';

Payment? paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment? data) => json.encode(data!.toJson());

class Payment {
    Payment({
        this.id,
        this.userId,
        this.paymentType,
        this.amount,
        this.date,
        this.paymentId,
        this.status,
        this.orderId,
    });

    String? id;
    String? userId;
    String? paymentType;
    String? amount;
    DateTime? date;
    String? paymentId;
    String? status;
    String? orderId;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        userId: json["userID"],
        paymentType: json["paymentType"],
        amount: json["Amount"],
        date: DateTime.parse(json["date"]),
        paymentId: json["paymentID"],
        status: json["status"],
        orderId: json["orderID"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "paymentType": paymentType,
        "Amount": amount,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "paymentID": paymentId,
        "status": status,
        "orderID": orderId,
    };
}
