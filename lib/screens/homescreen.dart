import 'package:book_finder/services/firestore.dart';
import 'package:book_finder/widgets/book_card.dart';
import 'package:book_finder/widgets/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../variables/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

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
        title: const Text('Probably recomended'),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Expanded(
                child: CardsList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(Routes.home),
    );
  }
}

class CardsList extends StatelessWidget {
  const CardsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.loadSimList(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, AsyncSnapshot snapshot) {
        Widget childer;
        if (snapshot.hasData) {
          childer = (snapshot.data.toString().replaceAll('[]', '').isNotEmpty)
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: snapshot.data
                        .map<Widget>((item) => BookCard(
                              author: item.author,
                              name: item.name,
                              isbn: item.isbn,
                              url: item.url,
                            ))
                        //TODO: разобраться с картинками, кидает 403
                        .toList(),
                  ),
                )
              : const Center(
                  child: Text('Read at least 1 book to get recommendations'),
                );
        } else if (snapshot.hasError) {
          childer = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Error occured...'),
              ],
            ),
          );
        } else {
          childer = Center(
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

        return childer;
      },
    );
  }
}
