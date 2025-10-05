import 'package:trivia_base/src/src.dart';

class IndexController extends GetxController {
  var currentIndex = 0.obs;
  var score = 0.obs;
  var wrong = 0.obs;
  bool isComplete = false;
  late List<Question> questions;
  late Question question;
  late DateTime _startTime;

  FirestoreServices controller = Get.find(tag: Literals.fsTag);

  /// marks the trivia complete so it is
  /// not stored in the database for later.
  void markComplete() {
    isComplete = true;
  }

  bool get checkCompletion => isComplete;

  int get getCurrentIndex => currentIndex.value;

  Question get getSingleQuestion => question;

  DateTime get startTime => _startTime;

  /// sets the start time of the trivia when it starts
  /// NOTE: the trivia's start time is not
  /// saved until the trivia is complete
  void setStartTime() {
    _startTime = DateTime.now();
  }

  /// Setting a single question set in memory for the current trivia.
  void setQuestions(List<Question> questionsList) {
    debugPrint("Setting start time");
    setStartTime();
    debugPrint("Set question list of length: ${questionsList.length}");
    questions = questionsList;
  }

  /// Update score on each button/option press by the user.
  /// and is saved at the end when the user has completed the trivia
  void updateScore(String answer) {
    if (answer == question.correctAnswer) {
      score.value++;
      debugPrint("Correct answer count: ${score.value}");
    } else {
      wrong.value++;
      debugPrint("Wrong answer count: ${wrong.value}");
    }
  }

  /// returns the value for the progress bar
  double getProgressValue() {
    debugPrint("Progress bar value: ${getCurrentIndex / questions.length}");
    return getCurrentIndex / questions.length;
  }

  /// Setting a single question out of the set based on
  /// the current index.
  void setSingleQue() {
    debugPrint("Set single question from the list");
    question = questions[currentIndex.value];
  }

  /// returns the current question set when user exits without completing trivia
  List<Question> get getIncompleteQuestionSet => questions;

  double getPercentage() {
    debugPrint("Getting percentage");
    debugPrint((score.value / questions.length).toString());
    return score.value / questions.length * 100;
  }

  /// Updates the index along with the score.
  /// If the user has completed all the quesitons present in the set
  /// then the user is navigated to the results screen along
  /// with appropriate arguments.
  Future<void> updateIndex(String answer, String triviaDocId) async {
    debugPrint("Index updated");
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
      debugPrint(currentIndex.value.toString());
      updateScore(answer);
      debugPrint("==> Updating UI");
      update();
    } else {
      FirestoreServices storeController = Get.find(
        tag: Literals.fsTag,
      );
      updateScore(answer);
      markComplete();
      debugPrint("Redirect to results view");
      debugPrint(
          "Score ${score.value}, Wrong ${wrong.value}, %age ${getPercentage()}");
      if (triviaDocId.isNotEmpty) {
        debugPrint("Deleting $triviaDocId");
        await storeController.deleteTrivia(docId: triviaDocId);
      }
      Get.off(
        () => ResultView(
          startTime: startTime,
          score: score.value,
          wrongAnswers: wrong.value,
          percentage: getPercentage(),
        ),
      );
    }
  }

  /// generating a new list of options
  /// by combining and shuffling the given options.
  List optionsList() {
    final List<dynamic> options = question.incorrectAnswers;
    if (!options.contains(question.correctAnswer)) {
      options.add(question.correctAnswer);
      options.shuffle();
    }
    return options;
  }
}
