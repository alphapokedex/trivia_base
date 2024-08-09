import 'package:trivia_base/src/src.dart';

class TriviaOptionsSheet extends StatelessWidget {
  const TriviaOptionsSheet({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder(
        init: TriviaOptionsController(),
        builder: (TriviaOptionsController controller) => Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(
                category.name,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(Literals.noOfQuestions),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: <Widget>[
                  ...[10, 20, 30, 40, 50].map(
                    (element) => ActionChip(
                      label: Text(element.toString()),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                      labelStyle: const TextStyle(color: Colors.white),
                      backgroundColor: controller.getNoOfQuestions == element
                          ? Colors.black
                          : Colors.grey,
                      onPressed: () =>
                          controller.selectNumberOfQuestions(element),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(Literals.difficulty),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: 16.0,
                children: <Widget>[
                  ...Literals.difficultyTypes.map(
                    (element) => ActionChip(
                      label: Text(element),
                      labelStyle: const TextStyle(color: Colors.white),
                      backgroundColor: controller.getDifficulty ==
                              (element != Literals.anyType
                                  ? element.toLowerCase()
                                  : null)
                          ? Colors.black
                          : Colors.grey,
                      onPressed: () => controller.selectDifficulty(
                        element != Literals.anyType
                            ? element.toLowerCase()
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            controller.getProcessing
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    child: const Text(Literals.startTrivia),
                    onPressed: () => controller.startTrivia(category),
                  ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
