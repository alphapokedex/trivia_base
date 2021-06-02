class ResultDocument {
  final int score;
  final int wrong;
  final double percentage;
  final String totalTime;

  ResultDocument({
    required this.score,
    required this.wrong,
    required this.percentage,
    required this.totalTime,
  });

  /// converts the passed [_JsonQueryDocumentSnapshot] into
  /// a usable dart [ResultDocument] object.
  factory ResultDocument.fromJsonQueryDocumentSnapshot(dynamic json) {
    return ResultDocument(
      percentage: json['Percentage'],
      score: json['Score'],
      wrong: json['Wrong'],
      totalTime: calculateTotalTime(json['Seconds']),
    );
  }

  /// Returns a string after calculating the [hh:mm:ss] from given [Seconds]
  static String calculateTotalTime(int seconds) {
    int hh = seconds ~/ 3600;
    seconds %= 3600;
    int mm = seconds ~/ 60;
    seconds %= 60;
    int ss = seconds;
    return "$hh:$mm:$ss";
  }
}
