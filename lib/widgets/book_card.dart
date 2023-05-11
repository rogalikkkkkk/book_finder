import 'package:book_finder/variables/routes.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final int? score;
  final DateTime? readTime;

  final String? name;
  final String? author;
  final String? url;

  const BookCard(
      {this.score, this.readTime, this.name, this.author, this.url, Key? key})
      : super(key: key);

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
                          (url != null) ? url! : netPicture,
                          // scale: 3.5,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text((name != null)
                              ? name!
                              : "Name of the bookName of the bookName of the bookName of the bookName of the bookName of the bookName of the book"),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Text((author != null)
                              ? author!
                              : "Books author Books author Books author Books author Books author Books author Books author Books author Books author Books author Books author Books author Books author "),
                          const SizedBox(
                            height: 15.0,
                          ),
                          score == null
                              ? TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () => {},
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
                                        score.toString(),
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
                score != null
                    ? Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                              child: TextButton(
                                onPressed: () => {},
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("Change score"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                  'You read this book at ${readTime!.day} ${readTime!.month} ${readTime!.year}'),
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
