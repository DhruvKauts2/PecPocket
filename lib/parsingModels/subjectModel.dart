// ignore_for_file: unused_local_variable, prefer_collection_literals

import 'package:pecpocket/classes/subjectClass.dart';

class SubjectList {
  late List<Subject> subjects;

  SubjectList({
    required this.subjects,
  });

  factory SubjectList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<Subject> subjects = [];
    subjects = parsedJson.map((i) => Subject.fromJson(i)).toList();

    return SubjectList(subjects: subjects);
  }
}
