import 'package:trivia_base/src/src.dart';

class TriviaScoreboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirestoreServices controller =
        Get.find<FirestoreServices>(tag: Literals.fsTag);
    return Scaffold(
      appBar: AppBar(
        title: Text(Literals.scoreboardBText),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.getResults(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active) {
            List? scorelist = snapshot.data!.docs;
            if (scorelist.isEmpty)
              return Center(
                child: Text(Literals.aww),
              );
            return ListView.builder(
              itemCount: scorelist.length,
              itemBuilder: (BuildContext context, int index) {
                ResultDocument element =
                    ResultDocument.fromJsonQueryDocumentSnapshot(
                        scorelist[index]);
                return ListTile(
                  title: Text("Percentage Score: ${element.percentage}"),
                  subtitle: Text(
                      "Corrent Answers: ${element.score}/${element.score + element.wrong}"),
                  trailing: Text("Total Time:\n${element.totalTime}"),
                );
              },
            );
          }
          return Center(
            child: Text(Literals.noData),
          );
        },
      ),
    );
  }
}
