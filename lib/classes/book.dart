import 'package:book_finder/services/firestore.dart';

class Book {
  final String isbn;
  final String author;
  final String name;
  final String url;

  Book(
      {required this.isbn,
      required this.author,
      required this.name,
      required this.url});

  Book.fromJSON(Map<String, Object?> json)
      : this(
          isbn: json['ISBN']! as String,
          author: json['author']! as String,
          name: json['name']! as String,
          url: json['link']! as String,
        );


  static Future<List<Book>> findInBooks(String pattern) async {
    return (await Firestore.getAllBooks())
        .where((book) => '${book.author} ${book.name}'
            .toLowerCase()
            .contains(pattern.toLowerCase()))
        .toList();
  }
}

class BookWRating {
  final String isbn;
  final String author;
  final String name;
  final String url;
  final int rating;

  BookWRating(
      {required this.isbn,
      required this.author,
      required this.name,
      required this.url,
      required this.rating});
}
