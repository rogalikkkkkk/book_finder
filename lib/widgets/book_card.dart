import 'package:book_finder/variables/routes.dart';
import 'package:book_finder/widgets/score_dialog.dart';
import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  final int? score;
  final DateTime? readTime;

  final String? name;
  final String? author;
  final String? url;
  final String isbn;

  const BookCard(
      {this.score,
      this.readTime,
      this.name,
      this.author,
      this.url,
      Key? key,
      required this.isbn})
      : super(key: key);

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  int? userScore;

  void callBack(int? newScore) {
    setState(() {
      userScore = newScore;
    });
  }

  @override
  void initState() {
    userScore = widget.score;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 150.0,
                        child: Image.network(
                          (widget.url != null) ? widget.url! : netPicture,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                              (widget.name != null)
                                  ? widget.name!
                                  : "Name of the book",
                              textAlign: TextAlign.center),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            (widget.author != null)
                                ? widget.author!
                                : "Books author",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          userScore == null
                              ? TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        ScoreDialog(
                                      score: userScore,
                                      isbn: widget.isbn,
                                      callBack: callBack,
                                    ),
                                  ),
                                  child: const Text('Already read'),
                                )
                              : Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Your score'),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        userScore.toString(),
                                        style: const TextStyle(fontSize: 30.0),
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      ),
                    )
                  ],
                ),
                userScore != null
                    ? Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                              child: TextButton(
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      ScoreDialog(
                                    score: userScore,
                                    isbn: widget.isbn,
                                    callBack: callBack,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("Change score"),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
