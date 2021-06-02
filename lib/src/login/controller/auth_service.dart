import 'package:trivia_base/src/src.dart';

class AuthenticationService extends GetxService {
  AuthenticationService(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;
  static FirestoreServices _firestoreService =
      Get.find<FirestoreServices>(tag: Literals.fsTag);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// signs out the user whenerver the logout button is pressed.
  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Signs in the new or old user into the application
  /// as well as sets the [uid] for further use in the application
  static Future gSignIn() async {
    UserCredential userInfo = await signInWithGoogle();
    print("SIGN IN GOOGLE: " + userInfo.toString());
    User user = userInfo.user!;
    _firestoreService.setUid(user.uid);
    await _firestoreService.initUser(
      name: user.displayName.toString(),
      email: user.photoURL.toString(),
    );
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// signs in a user using the provider email and passowrd
  /// throws and error to the user if already registered
  Future signIn({required String email, required String password}) async {
    try {
      return await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (UserCredential userInfo) async {
          print("SIGN IN EMAIL: " + userInfo.toString());
          User? user = userInfo.user;
          _firestoreService.setUid(user!.uid);
          await _firestoreService.initUser(
            name: (user.displayName ?? user.email.toString().split('@')[0])
                .toString(),
            email: user.email.toString(),
          );
          return userInfo;
        },
      ).catchError(
        (error) {
          Get.snackbar(
            "Error Occured!",
            error.toString(),
            colorText: Colors.white,
            backgroundColor: Colors.black,
          );
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
            print("SIGN UP: " + userInfo.toString());
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
      ).catchError(
        (error) {
          Get.snackbar(
            "Error Occured!",
            error.message,
            colorText: Colors.white,
            backgroundColor: Colors.black,
          );
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
