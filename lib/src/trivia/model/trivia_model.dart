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
  String type;
  String difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  /// converts a single [Map<String, dynamic>] object into a [Question] object
  factory Question.fromJson(Map<String, dynamic> json) => Question(
        category: json["category"],
        type: json["type"],
        difficulty: json["difficulty"],
        question: json["question"],
        correctAnswer: json["correct_answer"],
        incorrectAnswers:
            List<String>.from(json["incorrect_answers"].map((x) => x)),
      );

  /// converts a single [Question] object into a [Map<String, dynamic>] object
  Map<String, dynamic> toJson() => {
        "category": category,
        "type": type,
        "difficulty": difficulty,
        "question": question,
        "correct_answer": correctAnswer,
        "incorrect_answers": List<dynamic>.from(incorrectAnswers.map((x) => x)),
      };
}

extension QuestionX on Question  {
  Type get parsedType {
    return Type.values.firstWhere((e) => e.name == type);
  }

  Difficulty get parsedDifficulty {
    return Difficulty.values.firstWhere((e) => e.name == type);
  }
}

enum Difficulty { hard, medium, easy }

enum Type { multiple, boolean }
