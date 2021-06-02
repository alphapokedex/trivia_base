import 'dart:convert';

TriviaDb triviaDbFromJson(String str) => TriviaDb.fromJson(json.decode(str));

/// Used in translating the question set to a Map object for
/// it to be able to store in the Firestore database.
Map<String, dynamic> triviaDbToJson(TriviaDb data) => data.toJson();

class TriviaDb {
  TriviaDb({
    required this.questions,
  });

  List<Question> questions;

  factory TriviaDb.fromJson(Map<String, dynamic> json) => TriviaDb(
        questions: List<Question>.from(
            json["results"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  /// Single Question data class
  Question({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  String category;
  Type type;
  Difficulty difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  /// converts a single [Map<String, dynamic>] object into a [Question] object
  factory Question.fromJson(Map<String, dynamic> json) => Question(
        category: json["category"],
        type: typeValues.map[json["type"]]!,
        difficulty: difficultyValues.map[json["difficulty"]]!,
        question: json["question"],
        correctAnswer: json["correct_answer"],
        incorrectAnswers:
            List<String>.from(json["incorrect_answers"].map((x) => x)),
      );

  /// converts a single [Question] object into a [Map<String, dynamic>] object
  Map<String, dynamic> toJson() => {
        "category": category,
        "type": typeValues.reverse?[type],
        "difficulty": difficultyValues.reverse?[difficulty],
        "question": question,
        "correct_answer": correctAnswer,
        "incorrect_answers": List<dynamic>.from(incorrectAnswers.map((x) => x)),
      };
}

enum Difficulty { HARD, MEDIUM, EASY }

final difficultyValues = EnumValues({
  "easy": Difficulty.EASY,
  "hard": Difficulty.HARD,
  "medium": Difficulty.MEDIUM
});

enum Type { MULTIPLE, BOOLEAN }

final typeValues =
    EnumValues({"boolean": Type.BOOLEAN, "multiple": Type.MULTIPLE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  /// Reverses the map key pair for the
  /// smooth conversion in [Object.toJson()]
  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
