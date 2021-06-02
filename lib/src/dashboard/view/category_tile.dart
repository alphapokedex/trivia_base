import 'package:trivia_base/src/src.dart';

class CategoryTile extends StatelessWidget {
  /// A single custom widget tile made for the
  /// categories present in [DashboardView].
  /// Takes a string [categoryName] to
  /// display the kind of category on the tile.
  /// And a callback function which is specific
  /// for triggering a [BottomSheet] on [DashboardView].
  const CategoryTile({
    Key? key,
    required this.categoryName,
    required this.sheetCallback,
  }) : super(key: key);
  
  final String categoryName;
  final Function() sheetCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: sheetCallback,
        title: Text(
          categoryName,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
