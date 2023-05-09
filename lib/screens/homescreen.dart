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
            children: <Widget>[
              // Container(
              //   color: Colors.blue,
              //   height: 50.0,
              //   alignment: Alignment.centerLeft,
              //   width: double.infinity,
              //   child: const Padding(
              //     padding: EdgeInsets.all(8.0),
              //     child: Text(
              //       "Probably recomended",
              //       style: TextStyle(
              //           backgroundColor: Colors.blue,
              //           color: Colors.white,
              //           fontSize: 25.0),
              //     ),
              //   ),
              // ),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    routeString[Routes.profile]!,
                    (Route<dynamic> route) => false),
                child: const Text("Go to profile"),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: const [
                      BookCard(),
                      BookCard(),
                      BookCard(),
                      BookCard(),
                      BookCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(Routes.home),
    );
  }
}
