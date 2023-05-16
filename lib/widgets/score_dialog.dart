import 'package:book_finder/services/firestore.dart';
import 'package:book_finder/widgets/book_score_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScoreDialog extends StatefulWidget {
  const ScoreDialog({
    super.key,
    required this.score, required this.isbn, required this.callBack,
  });

  final String isbn;
  final int? score;
  final Function callBack;

  @override
  State<ScoreDialog> createState() => _ScoreDialogState();
}

class _ScoreDialogState extends State<ScoreDialog> {
  void callBack(int scoreFromChild) {
    setState(() {
      newScore = scoreFromChild;
    });
  }

  int newScore = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
                'Какую оценку вы поставите этой книге?'),
          ),
          const SizedBox(
            height: 10,
          ),
          BookScorePicker(score: widget.score, callBack: callBack),
          TextButton(
            onPressed: () {
              Firestore.setUserRatings(FirebaseAuth.instance.currentUser!.uid, widget.isbn, newScore);
              widget.callBack(newScore);
              Navigator.pop(context);
            },
            child: const Text('Оценить'),
          ),
        ],
      ),
    );
  }
}

