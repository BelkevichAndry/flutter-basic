class Note {
  final String text;
  final int id;
  final String createdAt;

  Note({required this.text, required this.id, required this.createdAt});
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
