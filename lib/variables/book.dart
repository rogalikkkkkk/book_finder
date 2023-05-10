class Book {
  final String isbn;
  final String author;
  final String name;
  final String url;

  Book({required this.isbn, required this.author, required this.name, required this.url});

  Book.fromJSON(Map<String, Object?> json)
      : this(
          isbn: json['ISBN']! as String,
          author: json['author']! as String,
          name: json['name']! as String,
          url: json['link']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'ISBN': isbn,
      'author': author,
      'link': url,
      'name': name,
    };
  }
}
