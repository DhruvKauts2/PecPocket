class Club {
  late String id;
  late String clubName;
  late String clubCode;
  late int v;

  Club(
      {required this.id,
      required this.clubName,
      required this.clubCode,
      required this.v});

  factory Club.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_new
    return new Club(
      id: json['_id'].toString(),
      clubName: json['clubName'],
      clubCode: json['clubAlias'],
      v: json["_v"],
    );
  }
}
