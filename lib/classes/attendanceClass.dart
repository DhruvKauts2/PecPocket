class Attendance {
  late String id;
  late String sid;
  late String subject;
  late int classesAttended;
  late int classesMissed;
  late String classStatus;
  late int v;

  Attendance({
    required this.id,
    required this.sid,
    required this.subject,
    required this.classesAttended,
    required this.classesMissed,
    required this.classStatus,
    required this.v,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_new
    return new Attendance(
      id: json['_id'].toString(),
      sid: json["sid"],
      subject: json["subject"],
      classesAttended: json["classesAttended"],
      classesMissed: json["classesMissed"],
      classStatus: json["classStatus"],
      v: json["_v"],
    );
  }
}
