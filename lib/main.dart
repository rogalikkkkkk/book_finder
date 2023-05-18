import 'package:book_finder/screens/homescreen.dart';
import 'package:book_finder/screens/library_screen.dart';
import 'package:book_finder/screens/login_screen.dart';
import 'package:book_finder/screens/profile.dart';
import 'firebase_options.dart';
import 'package:book_finder/screens/signup_screen.dart';
import 'package:book_finder/services/firebase_stream.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demonstration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const FirebaseStream(),
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/library': (context) => const LibraryScreen(),
      },
      initialRoute: '/',
    );
  }
}
