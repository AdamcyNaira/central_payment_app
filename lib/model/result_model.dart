// To parse this JSON data, do
//
//     final result = resultFromJson(jsonString);

import 'dart:convert';

Result? resultFromJson(String str) => Result.fromJson(json.decode(str));

String resultToJson(Result? data) => json.encode(data!.toJson());

class Result {
    Result({
        this.entryId,
        this.studentId,
        this.firstName,
        this.middleName,
        this.surname,
        this.degree,
        this.honours,
        this.classOfDegree,
        this.certificateNumber,
        this.awardDate,
        this.isGenerated,
        this.batch,
        this.createdBy,
        this.createdDate,
    });

    String? entryId;
    String? studentId;
    String? firstName;
    String? middleName;
    String? surname;
    String? degree;
    String? honours;
    String? classOfDegree;
    String? certificateNumber;
    String? awardDate;
    String? isGenerated;
    String? batch;
    String? createdBy;
    String? createdDate;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        entryId: json["EntryID"],
        studentId: json["StudentID"],
        firstName: json["FirstName"],
        middleName: json["MiddleName"],
        surname: json["Surname"],
        degree: json["Degree"],
        honours: json["Honours"],
        classOfDegree: json["ClassOfDegree"],
        certificateNumber: json["CertificateNumber"],
        awardDate: json["AwardDate"],
        isGenerated: json["IsGenerated"],
        batch: json["Batch"],
        createdBy: json["CreatedBy"],
        createdDate: json["CreatedDate"],
    );

    Map<String, dynamic> toJson() => {
        "EntryID": entryId,
        "StudentID": studentId,
        "FirstName": firstName,
        "MiddleName": middleName,
        "Surname": surname,
        "Degree": degree,
        "Honours": honours,
        "ClassOfDegree": classOfDegree,
        "CertificateNumber": certificateNumber,
        "AwardDate": awardDate,
        "IsGenerated": isGenerated,
        "Batch": batch,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate,
    };
}
