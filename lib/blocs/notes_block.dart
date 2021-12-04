import 'dart:async';

import 'package:noter/db/dbhelper.dart';
import 'package:noter/models/note.model.dart';

abstract class BlocBase {
  void dispose();
}

class NotesBloc implements BlocBase {
  final _notesController = StreamController<List<Note>>.broadcast();
  final _addNoteController = StreamController<CreateNote>.broadcast();
  final _removeNoteController = StreamController<int>.broadcast();

  StreamSink<List<Note>> get _inNotes => _notesController.sink;
  StreamSink<CreateNote> get inAddNote => _addNoteController.sink;
  StreamSink<int> get inRemoveNote => _removeNoteController.sink;

  Stream<List<Note>> get notes => _notesController.stream;

  NotesBloc() {
    getNotes();

    _addNoteController.stream.listen(_handleAddNote);
    _removeNoteController.stream.listen(_handleRemoveNote);
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

  void _handleAddNote(CreateNote note) async {
    final db = DBHelper();
    db.saveNote(note);
    getNotes();
  }

  void _handleRemoveNote(int id) async {
    final db = DBHelper();
    db.deleteNote(id);
  }
}
