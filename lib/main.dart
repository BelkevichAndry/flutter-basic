import 'package:flutter/material.dart';
import 'package:noter/widgets/notes-list.widget.dart';
import './widgets/add-note.widget.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quingo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/notes-list',
      routes: {
        '/notes-list': (context) => const HomePage(),
        '/add-note': (context) => const AddNotePage(
              title: 'Add new note',
            ),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quingo"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add-note');
          },
          child: const Icon(Icons.navigation),
          backgroundColor: Colors.green,
        ),
        body: NotesList());
  }
}
