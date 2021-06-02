import 'package:trivia_base/src/src.dart';

class TriviaOptionsController extends GetxController {
  var _noOfQuestions = 10.obs;
  var _difficulty = "easy".obs;
  var processing = false.obs;

  int get getNoOfQuestions => _noOfQuestions.value;
  String get getDifficulty => _difficulty.value;
  bool get getProcessing => processing.value;

  /// selects the number of questions
  /// tapped by the user and updates UI
  selectNumberOfQuestions(int i) {
    _noOfQuestions.value = i;
    update();
  }

  /// selects the difficulty tapped by the
  /// user and updates UI
  selectDifficulty(String? s) {
    _difficulty.value = s.toString();
    update();
  }

  /// starts the trivia when called and updates the UI twice
  /// when while listening to the [processing] boolean
  /// changes to indicate that the questions are loading
  /// and are done loading.
  startTrivia(Category category) async {
    processing.value = true;
    update();
    try {
      List<Question> questions = await QuestionsServices.getQuestions(
          category.id, _noOfQuestions.value, _difficulty.value);
      Get.back();

      /// If not enough questions then throws error to the user
      /// and returns without going futher.
      if (questions.length < 1) {
        Get.snackbar(
          Literals.notEnoughQues,
          Literals.notEnoughElaborated,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        return;
      }
      Get.to(
        () => TriviaView(
          categoryName: category.name,
          questions: questions,
        ),
      );
    } on SocketException catch (_) {
      Get.snackbar(
        Literals.unReachable,
        Literals.unReachableElaborated,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        Literals.oopsError,
        Literals.unexpectedError,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
    processing.value = false;
    update();
  }
}
