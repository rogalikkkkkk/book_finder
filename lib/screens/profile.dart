import 'package:book_finder/variables/routes.dart';
import 'package:book_finder/widgets/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            Text(user!.email!),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, routeString[Routes.home]!),
              // onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(routeString[Routes.home]!, (Route<dynamic> route) => false),
              child: const Text("Go to home"),
            ),
            TextButton(
              onPressed: () => signOut(),
              child: const Text("Sign out"),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(Routes.profile),
    );
  }
}
