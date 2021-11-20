class Note {
  final String text;

  Note({
    required this.text,
  });

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
