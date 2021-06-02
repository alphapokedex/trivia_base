import 'package:trivia_base/src/src.dart';

class TriviaOptionsSheet extends StatelessWidget {
  const TriviaOptionsSheet({
    Key? key,
    required this.category,
  }) : super(key: key);

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
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            SizedBox(height: 10.0),
            Text(Literals.noOfQuestions),
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
                      labelStyle: TextStyle(color: Colors.white),
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
            SizedBox(height: 20.0),
            Text(Literals.difficulty),
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
                      labelStyle: TextStyle(color: Colors.white),
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
            SizedBox(height: 20.0),
            controller.getProcessing
                ? CircularProgressIndicator()
                : ElevatedButton(
                    child: Text(Literals.startTrivia),
                    onPressed: () => controller.startTrivia(category),
                  ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
