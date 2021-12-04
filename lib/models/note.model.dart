class Note {
  final String text;
  final int id;

  Note({required this.text, required this.id});

  Map<String, dynamic> toMap() {
    return {'text': text, 'id': id};
  }

  @override
  String toString() {
    return 'Note{text: $text id$id}';
  }
}

class CreateNote {
  final String text;

  CreateNote({required this.text});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  @override
  String toString() {
    return 'Note{text: $text}';
  }
}
