import 'package:flutter/material.dart';

class CustomReminder {
  late String id;
  late int sid;
  late String reminderTitle;
  late String reminderDescription;
  late String reminderDate;
  late String reminderTime;

  late int v;

  CustomReminder({
    required this.id,
    required this.sid,
    required this.reminderTitle,
    required this.reminderDescription,
    required this.reminderDate,
    required this.reminderTime,
    required this.v,
  });

  factory CustomReminder.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_new
    return new CustomReminder(
      id: json["_id"].toString(),
      sid: json["sid"],
      reminderTitle: json["reminderTitle"],
      reminderDescription: json["reminderDescription"],
      reminderDate: json["reminderDate"],
      reminderTime: json["reminderTime"],
      v: json["_v"],
    );
  }
}
