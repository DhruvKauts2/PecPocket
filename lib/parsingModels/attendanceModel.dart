// ignore_for_file: unused_local_variable, prefer_collection_literals

import '../classes/attendanceClass.dart';

class AttendanceList {
  late List<Attendance> attendance;

  AttendanceList({
    required this.attendance,
  });

  factory AttendanceList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<Attendance> attendance = [];
    attendance = parsedJson.map((i) => Attendance.fromJson(i)).toList();

    return AttendanceList(attendance: attendance);
  }
}
