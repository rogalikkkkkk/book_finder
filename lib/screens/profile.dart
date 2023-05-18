import 'package:book_finder/classes/book.dart';
import 'package:book_finder/variables/routes.dart';
import 'package:book_finder/widgets/book_card.dart';
import 'package:book_finder/widgets/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Book> booksList = List.empty();
  TextEditingController userText = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    userText.dispose();
    super.dispose();
  }

  Future<void> signOut() async {
    final navigator = Navigator.of(context);

    await FirebaseAuth.instance.signOut();

    navigator.pushNamedAndRemoveUntil(
        '/login', (Route<dynamic> route) => false);
  }

  void changeBooksList() async {
    var isValid = formKey.currentState!.validate();
    if (isValid) {
      List<Book> filteredBooks = await Book.findInBooks(userText.text.trim());
      setState(() {
        booksList = filteredBooks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find books in library'),
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: userText,
                        autocorrect: false,
                        validator: (text) => text != null && text.length < 3
                            ? 'Минимум 3 символа'
                            : null,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Введите название или автора'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: changeBooksList,
                        child: const Center(child: Text('Найти')),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: booksList
                        .map<BookCard>((book) => BookCard(
                              author: book.author,
                              name: book.name,
                              isbn: book.isbn,
                            ))
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(Routes.profile),
    );
  }
}
