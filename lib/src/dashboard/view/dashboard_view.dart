import 'package:trivia_base/src/src.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({
    super.key,
    required this.email,
  });

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DashboardDrawer(
        email: email.toString(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 15,
            shadowColor: Colors.indigo,
            expandedHeight: 180,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(Literals.categoryTitle),
              background: Image.network(
                Literals.randomImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                ...categories
                    .map(
                      (element) => CategoryTile(
                        categoryName: element.name,
                        sheetCallback: () => Get.bottomSheet(
                          BottomSheet(
                            onClosing: () {},
                            builder: (BuildContext context) =>
                                TriviaOptionsSheet(
                              category: element,
                            ),
                          ),
                        ),
                      ),
                    )
                    ,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
