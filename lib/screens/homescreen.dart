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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("HomeScreen"),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(routeString[Routes.profile]!, (Route<dynamic> route) => false),
              child: const Text("Go to profile"),
            ),
            TextButton(
              onPressed: () => signOut(),
              child: const Text("Sign out"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(Routes.home),
    );
  }
}
