import 'dart:async';

import 'package:noter/db/dbhelper.dart';
import 'package:noter/models/note.model.dart';

abstract class BlocBase {
  void dispose();
}

class NotesBloc implements BlocBase {
  final _notesController = StreamController<List<Note>>.broadcast();

  StreamSink<List<Note>> get _inNotes => _notesController.sink;

  Stream<List<Note>> get notes => _notesController.stream;

  final _addNoteController = StreamController<Note>.broadcast();
  StreamSink<Note> get inAddNote => _addNoteController.sink;

  NotesBloc() {
    getNotes();

    _addNoteController.stream.listen(_handleAddNote);
  }

  @override
  void dispose() {
    _notesController.close();
    _addNoteController.close();
  }

  void getNotes() async {
    final db = DBHelper();
    List<Note> notes = await db.getNotes();

    _inNotes.add(notes);
  }

  void _handleAddNote(Note note) async {
    final db = DBHelper();
    db.saveNote(note);
    getNotes();
  }
}
