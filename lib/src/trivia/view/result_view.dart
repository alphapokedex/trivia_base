import 'package:trivia_base/src/src.dart';

class ResultView extends StatelessWidget {
  /// ResultView is a screen to show the result of the currently
  /// completed trivia in a presentable manner.
  const ResultView({
    Key? key,
    required this.startTime,
    required this.score,
    required this.wrongAnswers,
    required this.percentage,
  }) : super(key: key);

  final DateTime startTime;
  final int score;
  final int wrongAnswers;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    TextStyle heading = theme.bodyText1!.copyWith(fontSize: 18);
    FirestoreServices controller = Get.find(tag: Literals.fsTag);
    controller.addResult(
      startTime: startTime,
      score: score,
      wrong: wrongAnswers,
      percentage: percentage,
    );

    /// Returns the user to the dashboard after 5 seconds
    /// and stops/disposes the ticker
    Timer.periodic(
      Duration(seconds: 1),
      (Timer clock) {
        print(clock.tick);
        if (clock.tick > 5) {
          clock.cancel();
          Get.back();
        }
      },
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Text(
              score > wrongAnswers ? Literals.kudos : Literals.readMore,
              style: theme.headline5!.copyWith(
                color: score > wrongAnswers ? Colors.green : Colors.red,
              ),
            ),
            Spacer(flex: 2),
            Text(
              Literals.correct,
              style: heading,
            ),
            Text(
              score.toString(),
            ),
            SizedBox(height: 10),
            Text(
              Literals.wrong,
              style: heading,
            ),
            Text(
              wrongAnswers.toString(),
            ),
            SizedBox(height: 10),
            Text(
              Literals.pAge,
              style: heading,
            ),
            Text(
              percentage.toString(),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
