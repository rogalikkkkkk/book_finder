import 'package:book_finder/services/firestore.dart';
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
  final user = FirebaseAuth.instance.currentUser!.uid;

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
                child: UserBooksCards(user: user),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(Routes.library),
    );
  }
}

class UserBooksCards extends StatelessWidget {
  final String user;

  const UserBooksCards({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.getUserRatings(user),
      builder: (context, AsyncSnapshot snapshot) {
        Widget child;
        if (snapshot.hasData) {
          child = (snapshot.data.toString().replaceAll('[]', '').isNotEmpty)
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: snapshot.data
                        .map<Widget>((item) => BookCard(
                              author: item.author,
                              name: item.name,
                              score: item.rating,
                              isbn: item.isbn,
                              // url: item.url,
                            ))
                        //TODO: разобраться с картинками, кидает 403
                        .toList(),
                  ),
                )
              : const Center(child: Text('No read books yet'));
        } else if (snapshot.hasError) {
          child = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Error occured...'),
              ],
            ),
          );
        } else {
          child = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Loading data'),
                SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        }

        return child;
      },
    );
  }
}
