import 'dart:convert';

import 'package:book_finder/variables/book.dart';
import 'package:book_finder/variables/recomendtion.dart';
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
    final String response =
        await rootBundle.loadString('assets/allMovies.json');
    final data = await json.decode(response) as List<dynamic>;
    return data.map((item) => Book.fromJSON(item)).toList();
  }

  static Future<List<Book>> loadSimList(String userId) async {
    var alreadyRead = await getUserRatings(userId);
    if (alreadyRead == null) {
      return List.empty();
    }

    alreadyRead.sort((a, b) {
      if (a.rating > b.rating) {
        return -1;
      } else if (a.rating == b.rating) {
        return 0;
      } else {
        return 1;
      }
    });

    final readedIsbn = alreadyRead.map((book) => book.isbn).toList();

    final String resp = await rootBundle.loadString('assets/simil.json');
    final data = await json.decode(resp) as List<dynamic>;
    final res = data.map((item) => Recommendation.fromJSON(item)).toList();

    var readedWRecomended = res
        .where((element) => readedIsbn.contains(element.bookForRec))
        .toList();

    List<Recommendation> readedWRecomendedSorted = [];

    for (var element in readedIsbn) {
      readedWRecomendedSorted.addAll(readedWRecomended.where((item) => item.bookForRec == element));
    }

    Set<String> recommendationsListDirty = {};
    for (var element in readedWRecomendedSorted) {
      recommendationsListDirty.add(element.book0);
      recommendationsListDirty.add(element.book1);
      recommendationsListDirty.add(element.book0);
      recommendationsListDirty.add(element.book3);
      recommendationsListDirty.add(element.book4);
    }

    var recommendationsListClean = recommendationsListDirty
        .where((element) => !readedIsbn.contains(element))
        .toList();

    List<Book> responseList = [];
    final userRef = FirebaseFirestore.instance.collection('books');

    for (var element in recommendationsListClean) {
      final books = (await userRef.where('ISBN', isEqualTo: element).get())
          .docs
          .map((book) => Book.fromJSON(book.data()))
          .toList();
      for (var element in books) {responseList.add(element);}
    }

    return responseList;
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
