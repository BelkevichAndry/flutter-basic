import 'package:flutter/material.dart';
import 'package:noter/blocs/notes_block.dart';

class NotesProvider extends InheritedWidget {
  final bloc = NotesBloc();
  NotesProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  static NotesBloc? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<NotesProvider>()?.bloc;

  @override
  updateShouldNotify(NotesProvider oldWidget) {
    return true;
  }
}
