import 'package:trivia_base/src/src.dart';

class TriviaView extends StatelessWidget {
  /// The UI View of each trivia.
  /// [upload] parameter is given only when the
  /// question set is uploaded to Firebase in case
  /// the user leaves the trivia screen without completing it.
  /// and [triviaDocId] for when the incomplete trivia coming
  /// from database has to be deleted once completed.
  TriviaView({
    super.key,
    required this.categoryName,
    required this.questions,
    this.upload = true,
    this.triviaDocId = "",
  });

  final String categoryName;
  final List<Question> questions;
  final bool upload;
  final String triviaDocId;

  final HtmlUnescape charCode = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    /// Instantiating [IndexController] controller instance.
    IndexController indexController = IndexController();

    indexController.setQuestions(questions);

    debugPrint("Before Completion${indexController.checkCompletion}");

    return GetBuilder<IndexController>(
      init: indexController,
      builder: (IndexController controller) {
        controller.setSingleQue();

        var options = controller.optionsList();

        /// [onPopInvoked] saves the current question set in the
        /// database in case the user decides to leave
        /// without completing trivia.
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) return;
            /// Finds the [FirestoreService] dependancy we injected
            /// at the start of the App life cycle.
            FirestoreServices storeController = Get.find(
              tag: Literals.fsTag,
            );
            if (!controller.checkCompletion && upload) {
              debugPrint("Marking incomplete and adding to user db");

              storeController.addTrivia(
                categoryName: categoryName,
                incompleteTriviaQuestionSet:
                    controller.getIncompleteQuestionSet,
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(Literals.appTitle),
            ),
            body: Column(
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.grey.shade200,
                  value: controller.getProgressValue(),
                  minHeight: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 300,
                  child: Center(
                    child: Text(
                      charCode.convert(
                          controller.getSingleQuestion.question.toString()),
                      style: Theme.of(context).textTheme.titleLarge,
                      softWrap: true,
                    ),
                  ),
                ),
                ...options
                    .map(
                      (e) => TextButton(
                        onPressed: () =>
                            controller.updateIndex(e.toString(), triviaDocId),
                        child: Text(
                          charCode.convert(e.toString()),
                        ),
                      ),
                    )
                    ,
              ],
            ),
          ),
        );
      },
    );
  }
}
