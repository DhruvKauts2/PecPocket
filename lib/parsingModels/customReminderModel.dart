// ignore_for_file: unused_local_variable, prefer_collection_literals

import 'package:pecpocket/classes/customReminderClass.dart';

class CustomReminderList {
  late List<CustomReminder> customReminders;

  CustomReminderList({
    required this.customReminders,
  });

  factory CustomReminderList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<CustomReminder> customReminders = [];
    customReminders =
        parsedJson.map((i) => CustomReminder.fromJson(i)).toList();

    return CustomReminderList(customReminders: customReminders);
  }
}
