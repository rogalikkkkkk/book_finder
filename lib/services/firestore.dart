import 'package:book_finder/variables/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  static Future<List<Book>> getBooksCollection(String colName) async {
    var a = (await FirebaseFirestore.instance.collection(colName).get())
        .docs
        .map((item) => item.id);
    return (await FirebaseFirestore.instance.collection(colName).get())
        .docs
        .map((item) => Book.fromJSON(item.data()))
        .toList();
  }

  static Future<Map<String, dynamic>?> getUserRatings(String userId) async {
    var ratingsMap = (await FirebaseFirestore.instance.collection('ratings')
        .doc(userId).get()).data();
    if (ratingsMap != null) {
      ratingsMap = ratingsMap['ratings'];
    }
    return ratingsMap;
  }

  static Future<void> setUserRatings(
      String userId, String bookIsbn, int score) async {
    final userRef =
        FirebaseFirestore.instance.collection('ratings').doc(userId);
    await userRef.get().then((value) {
      if (value.exists) {
        userRef.update({'ratings.$bookIsbn': score});
      } else {
        userRef.set({
          'ratings': {bookIsbn: score}
        });
      }
    });
  }
}
//zLzASy2SJjPL4onB7CX0kxs5XXj2
