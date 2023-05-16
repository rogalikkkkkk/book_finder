class Recommendation {
  final String book0;
  final String book1;
  final String book2;
  final String book3;
  final String book4;
  final String bookForRec;

  Recommendation(
      {required this.book0,
      required this.book1,
      required this.book2,
      required this.book3,
      required this.book4,
      required this.bookForRec});

  Recommendation.fromJSON(Map<String, Object?> json)
      : this(
          book0: json['0']! as String,
          book1: json['1']! as String,
          book2: json['2']! as String,
          book3: json['3']! as String,
          book4: json['4']! as String,
          bookForRec: json['ISBN']! as String,
        );

}
