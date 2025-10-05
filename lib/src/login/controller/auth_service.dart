import 'package:trivia_base/src/src.dart';

class AuthenticationService extends GetxService {
  AuthenticationService(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;
  static final FirestoreServices _firestoreService =
      Get.find<FirestoreServices>(tag: Literals.fsTag);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// signs out the user whenerver the logout button is pressed.
  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  /// signs in a user using the provider email and passowrd
  /// throws and error to the user if already registered
  Future signIn({required String email, required String password}) async {
    try {
      return await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (UserCredential userInfo) async {
          debugPrint("SIGN IN EMAIL: $userInfo");
          User? user = userInfo.user;
          _firestoreService.setUid(user!.uid);
          await _firestoreService.initUser(
            name: (user.displayName ?? user.email.toString().split('@')[0])
                .toString(),
            email: user.email.toString(),
          );
          return userInfo;
        },
      );
    } catch (error) {
      Get.snackbar(
        "You ran into an error!",
        error.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
    }
  }

  /// signs up the user via the provided email and password for the
  /// future sign in capability
  Future signUp({required String email, required String password}) async {
    try {
      return await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (UserCredential? userInfo) async {
          if (userInfo != null) {
            debugPrint("SIGN UP: $userInfo");
            User user = userInfo.user!;
            _firestoreService.setUid(user.uid);
            await _firestoreService.initUser(
              name: (user.displayName ?? user.email.toString().split('@')[0])
                  .toString(),
              email: user.photoURL.toString(),
            );
            return userInfo;
          }
        },
      );
    } catch (error) {
      Get.snackbar(
        "You ran into an error!",
        error.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
    }
  }
}
