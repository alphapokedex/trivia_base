import 'package:trivia_base/src/src.dart';

class IncompleteTriviaView extends StatelessWidget {
  const IncompleteTriviaView({super.key});

  @override
  Widget build(BuildContext context) {
    FirestoreServices controller =
        Get.find<FirestoreServices>(tag: Literals.fsTag);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Literals.triviaBText),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.getIncompleteTrivias(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active) {
            List? trivialist = snapshot.data!.docs;
            if (trivialist.isEmpty) {
              return const Center(
                child: Text(Literals.good),
              );
            }
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
          return const Center(
            child: Text(Literals.noData),
          );
        },
      ),
    );
  }
}
