import 'package:trivia_base/src/src.dart';

class QuestionsServices {
  /// This is a provider function for the questions
  /// The OpenTiviaApi is used here to fetch questions with appropriate queryset.
  static Future<List<Question>> getQuestions(
      int? categoryId, int total, String? difficulty) async {
    String url = "${Literals.triviaUrl}?amount=$total&type=multiple";
    if (categoryId != null) {
      url = "$url&category=$categoryId";
    }
    if (difficulty != null) {
      url = "$url&difficulty=$difficulty";
    }
    Response res = await get(Uri.parse(url));
    return triviaDbFromJson(res.body).questions;
  }
}
