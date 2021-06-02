import 'package:trivia_base/src/src.dart';

void main() async {
  /// Returns an instance of the WidgetsBinding, creating and initializing it
  /// if necessary. If one is created, it will be a WidgetsFlutterBinding. If
  /// one was previously initialized, then it will at least implement WidgetsBinding.
  /// You only need to call this method if you need the binding to be
  /// initialized before calling runApp.
  WidgetsFlutterBinding.ensureInitialized();

  /// Injects [FirestoreServices] Dependancy permanently into the memory
  /// until the app is alive.
  Get.lazyPut(
    () => FirestoreServices(),
    tag: Literals.fsTag,
  );

  /// Injects [AuthenticationService] Dependancy into the memory for later use.
  Get.lazyPut(
    () => AuthenticationService(FirebaseAuth.instance),
    tag: Literals.asTag,
  );

  /// Initializes the DEFAULT app for Firebase and configures it
  /// for safe connection between application and the Firebase APIs.
  await Firebase.initializeApp();
  runApp(TriviaBaseApp());
}
