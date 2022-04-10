class Subject {
  late String id;
  late String subjectName;
  late String subjectCode;
  late int v;

  Subject(
      {required this.id,
      required this.subjectName,
      required this.subjectCode,
      required this.v});

  factory Subject.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_new
    return new Subject(
      id: json['_id'].toString(),
      subjectName: json['subjectName'],
      subjectCode: json['subjectCode'],
      v: json["_v"],
    );
  }
}
