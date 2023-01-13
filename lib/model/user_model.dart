import 'dart:convert';

Users? usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users? data) => json.encode(data!.toJson());

class Users {
    Users({
        this.name,
        this.email,
        this.phone,
        this.password,
        this.id,
    });

    String? name;
    String? email;
    String? phone;
    String? password;
    String? id;

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "id": id,
    };
}
