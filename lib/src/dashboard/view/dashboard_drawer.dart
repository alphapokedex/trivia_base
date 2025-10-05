import 'package:trivia_base/src/src.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Literals.loginImage),
                fit: BoxFit.cover,
              ),
            ),
            accountEmail: Text(email),
            accountName: Container(),
            currentAccountPictureSize: const Size(80, 80),
            currentAccountPicture: Center(
              child: Text(
                email.substring(0, 1).toUpperCase(),
                style: const TextStyle(
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
            icon: const FaIcon(FontAwesomeIcons.rectangleList),
            label: const Text(Literals.scoreboardBText),
            onPressed: () {
              Get.to(() => const TriviaScoreboardView());
            },
          ),
          TextButton.icon(
            icon: const FaIcon(FontAwesomeIcons.quora),
            label: const Text(Literals.triviaBText),
            onPressed: () {
              Get.to(() => const IncompleteTriviaView());
            },
          ),
          TextButton.icon(
            icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
            label: const Text(Literals.logoutBText),
            onPressed: () {
              AuthenticationService(FirebaseAuth.instance).signOut();
            },
          ),
        ],
      ),
    );
  }
}
