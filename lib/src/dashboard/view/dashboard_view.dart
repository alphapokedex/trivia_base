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
            pinned: true,
            title: Text(Literals.categoryTitle),
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
