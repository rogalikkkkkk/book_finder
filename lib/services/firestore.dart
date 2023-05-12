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

}
