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
  markComplete() {
    isComplete = true;
  }

  bool get checkCompletion => isComplete;

  int get getCurrentIndex => currentIndex.value;

  Question get getSingleQuestion => question;

  DateTime get startTime => _startTime;

  /// sets the start time of the trivia when it starts
  /// NOTE: the trivia's start time is not
  /// saved until the trivia is complete
  setStartTime() {
    _startTime = DateTime.now();
  }

  /// Setting a single question set in memory for the current trivia.
  setQuestions(questionsList) {
    print("Setting start time");
    setStartTime();
    print("Set question list of length: ${questionsList.length}");
    questions = questionsList;
  }

  /// Update score on each button/option press by the user.
  /// and is saved at the end when the user has completed the trivia
  updateScore(String answer) {
    if (answer == question.correctAnswer) {
      score.value++;
      print("Correct answer count: ${score.value}");
    } else {
      wrong.value++;
      print("Wrong answer count: ${wrong.value}");
    }
  }

  /// returns the value for the progress bar
  double getProgressValue() {
    print("Progress bar value: ${getCurrentIndex / questions.length}");
    return getCurrentIndex / questions.length;
  }

  /// Setting a single question out of the set based on
  /// the current index.
  setSingleQue() {
    print("Set single question from the list");
    question = questions[currentIndex.value];
  }

  /// returns the current question set when user exits without completing trivia
  List<Question> get getIncompleteQuestionSet => questions;

  double getPercentage() {
    print("Getting percentage");
    print(score.value / questions.length);
    return score.value / questions.length * 100;
  }

  /// Updates the index along with the score.
  /// If the user has completed all the quesitons present in the set
  /// then the user is navigated to the results screen along
  /// with appropriate arguments.
  updateIndex(String answer, String triviaDocId) async {
    print("Index updated");
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
      print(currentIndex.value.toString());
      updateScore(answer);
      print("==> Updating UI");
      update();
    } else {
      FirestoreServices storeController = Get.find(
        tag: Literals.fsTag,
      );
      updateScore(answer);
      markComplete();
      print("Redirect to results view");
      print(
          "Score ${score.value}, Wrong ${wrong.value}, %age ${getPercentage()}");
      if (triviaDocId.isNotEmpty) {
        print("Deleting $triviaDocId");
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
