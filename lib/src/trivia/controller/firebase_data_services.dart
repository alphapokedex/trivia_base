import 'package:trivia_base/src/src.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class FirestoreServices extends GetxService {
  late String _uid;

  setUid(String uid){
    _uid = uid;
  }

  /// Adds the new user at the time of signup to
  /// the list of users in the database.
  Future initUser({
    required String name,
    required String email,
  }) async {
    DocumentReference documentReferencer = _userCollection.doc(_uid);

    Map<String, dynamic> data = <String, dynamic>{
      "Name": name,
      "Email": email,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Added $_uid in the collection "))
        .catchError((e) => print(e));
  }

  /// Takes [categoryName] which is category name [String]
  /// and [incompleteTriviaQuestionSet] is [List<Question>] containing
  /// the list of incomplete tivia questions
  Future<void> addTrivia({
    required String categoryName,
    required List<Question> incompleteTriviaQuestionSet,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(_uid).collection('trivias').doc();

    Map<String, dynamic> data = {
      "Category": categoryName,
      "Results": triviaDbToJson(
        TriviaDb(
          questions: incompleteTriviaQuestionSet,
        ),
      )
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Added new trivia to $_uid\'s collection"))
        .catchError((e) => print(e));
  }

  /// Adds the result mainly time in [Seconds], [Score],
  /// [Wrong] and [Percentage] passed through constructor
  /// to the database in the respective document.
  Future<void> addResult({
    required DateTime startTime,
    required int score,
    required int wrong,
    required double percentage,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(_uid).collection('results').doc();

    int seconds = DateTime.now().difference(startTime).inSeconds;

    Map<String, dynamic> data = <String, dynamic>{
      "Seconds": seconds,
      "Score": score,
      "Wrong": wrong,
      "Percentage": percentage,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Added new result to $_uid\'s collection"))
        .catchError((e) => print(e));
  }

  /// Returns a stream of all the results present in the collection
  Stream<QuerySnapshot> getResults() {
    CollectionReference resultCollection =
        _userCollection.doc(_uid).collection('results');

    return resultCollection.orderBy('Seconds').snapshots();
  }

  /// Returns a stream of all the incomplete
  /// trivia present in the collection
  Stream<QuerySnapshot> getIncompleteTrivias() {
    CollectionReference triviaCollection =
        _userCollection.doc(_uid).collection('trivias');

    return triviaCollection.snapshots();
  }

  /// Deletes the respective document of trivia which is now complete
  /// using the [docId] passed to it
  Future<void> deleteTrivia({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _userCollection.doc(_uid).collection('trivias').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Trivia deleted from $_uid\'s collection'))
        .catchError((e) => print(e));
  }
}
