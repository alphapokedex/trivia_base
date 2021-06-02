import 'package:trivia_base/src/src.dart';

class IncompleteTriviaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirestoreServices controller =
        Get.find<FirestoreServices>(tag: Literals.fsTag);
    return Scaffold(
      appBar: AppBar(
        title: Text(Literals.triviaBText),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.getIncompleteTrivias(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active) {
            List? trivialist = snapshot.data!.docs;
            if (trivialist.isEmpty)
              return Center(
                child: Text(Literals.good),
              );
            return ListView.builder(
              itemCount: trivialist.length,
              itemBuilder: (BuildContext context, int index) {
                List<Question> quesitonSet =
                    TriviaDb.fromJson(trivialist[index]["Results"]).questions;
                return CategoryTile(
                  categoryName: trivialist[index]["Category"],
                  sheetCallback: () {
                    Get.to(
                      () => TriviaView(
                        questions: quesitonSet,
                        categoryName: trivialist[index]["Category"],
                        upload: false,
                        triviaDocId: trivialist[index].reference.id,
                      ),
                    );
                  },
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
