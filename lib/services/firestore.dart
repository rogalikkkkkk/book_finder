import 'dart:convert';

import 'package:book_finder/variables/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Firestore {
  static Future<List<Book>> getBooksCollection(String colName) async {
    return (await FirebaseFirestore.instance.collection(colName).get())
        .docs
        .map((item) => Book.fromJSON(item.data()))
        .toList();
  }

  static Future<List<BookWRating>?> getUserRatings(String userId) async {
    List<BookWRating>? booksWRatingsList;
    var ratingsMap = (await FirebaseFirestore.instance
            .collection('ratings')
            .doc(userId)
            .get())
        .data();
    if (ratingsMap != null) {
      ratingsMap = ratingsMap['ratings'];
      booksWRatingsList = (await FirebaseFirestore.instance
              .collection('books')
              .where('ISBN', whereIn: ratingsMap!.keys)
              .get())
          .docs
          .map((book) {
        final Book curBook = Book.fromJSON(book.data());
        final rating = ratingsMap![curBook.isbn];
        return BookWRating(
          isbn: curBook.isbn,
          author: curBook.author,
          name: curBook.name,
          url: curBook.url,
          rating: rating,
        );
      }).toList();
    }

    return booksWRatingsList;
  }

  static Future<List<Book>> getAllBooks() async {
    final String response = await rootBundle.loadString('assets/allMovies.json');
    final data = await json.decode(response) as List<dynamic>;
    return data.map((item) => Book.fromJSON(item)).toList();
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
