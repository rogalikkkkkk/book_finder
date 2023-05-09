import 'package:book_finder/variables/routes.dart';
import 'package:book_finder/widgets/book_card.dart';
import 'package:book_finder/widgets/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {

  Future<void> signOut() async {
    final navigator = Navigator.of(context);

    await FirebaseAuth.instance.signOut();

    navigator.pushNamedAndRemoveUntil(
        '/login', (Route<dynamic> route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your library'),
        actions: [
          IconButton(
            onPressed: () => signOut(),
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      BookCard(
                        score: 7,
                        readTime: DateTime.parse('1969-07-20 20:18:04Z'),
                      ),
                      BookCard(
                        score: 8,
                        readTime: DateTime.parse('1969-07-20 20:18:04Z'),
                      ),
                      BookCard(
                        score: 5,
                        readTime: DateTime.parse('1969-07-20 20:18:04Z'),
                      ),
                      BookCard(
                        score: 1,
                        readTime: DateTime.parse('1969-07-20 20:18:04Z'),
                      ),
                      BookCard(
                        score: 2,
                        readTime: DateTime.parse('1969-07-20 20:18:04Z'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(Routes.library),
    );
  }
}
