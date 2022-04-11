// ignore_for_file: unused_local_variable, prefer_collection_literals

import 'package:pecpocket/classes/clubClass.dart';

class ClubList {
  late List<Club> clubs;

  ClubList({
    required this.clubs,
  });

  factory ClubList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<Club> clubs = [];
    clubs = parsedJson.map((i) => Club.fromJson(i)).toList();

    return ClubList(clubs: clubs);
  }
}
