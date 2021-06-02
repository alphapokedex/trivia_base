import 'package:trivia_base/src/src.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = Get.find<AuthenticationService>(tag: Literals.asTag);
    return StreamBuilder(
      stream: firebaseUser.authStateChanges,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data!;
          return DashboardView(
            email: user.email,
          );
        }
        return LoginView();
      },
    );
  }
}
