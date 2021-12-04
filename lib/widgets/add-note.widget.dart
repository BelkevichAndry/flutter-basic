import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noter/blocs/bloc_provider.dart';
import 'package:noter/models/note.model.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AddNotePage> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNotePage> {
  final TextEditingController _number = TextEditingController();
  final TextEditingController _string = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = NotesProvider.of(context);
    if (bloc != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: _string,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "add note"),
                        validator: (value) {
                          if (value!.isEmpty) return "Please, fill data";
                          if (value.length < 3) {
                            return "Please enter at least 3 characters for your string";
                          }
                          if (!RegExp(r"^[A-Za-z ]+$").hasMatch(value)) {
                            return "Please provide only characters from A-Z ";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pop(context);
                            final note = Note(text: _string.text);
                            bloc.inAddNote.add(note);
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return new Container(
        alignment: AlignmentDirectional.center,
        child: new CircularProgressIndicator(),
      );
    }
  }
}
