import 'package:trivia_base/src/src.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Literals.loginImage),
                fit: BoxFit.cover,
              ),
            ),
            accountEmail: Text(email),
            accountName: Container(),
            currentAccountPictureSize: Size(80, 80),
            currentAccountPicture: Center(
              child: Text(
                email.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.lightGreen,
                  shadows: [
                    Shadow(
                      color: Colors.white54,
                      offset: Offset(3, 3),
                    ),
                  ],
                  fontSize: 50,
                ),
              ),
            ),
          ),
          TextButton.icon(
            icon: FaIcon(FontAwesomeIcons.listAlt),
            label: Text(Literals.scoreboardBText),
            onPressed: () {
              Get.to(() => TriviaScoreboardView());
            },
          ),
          TextButton.icon(
            icon: FaIcon(FontAwesomeIcons.quora),
            label: Text(Literals.triviaBText),
            onPressed: () {
              Get.to(() => IncompleteTriviaView());
            },
          ),
          TextButton.icon(
            icon: FaIcon(FontAwesomeIcons.signOutAlt),
            label: Text(Literals.logoutBText),
            onPressed: () {
              AuthenticationService(FirebaseAuth.instance).signOut();
            },
          ),
        ],
      ),
    );
  }
}
