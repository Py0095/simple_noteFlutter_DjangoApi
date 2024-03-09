class Note {
  final int id;
  final String title;
  final String content;
  final String created;
  final String updated;


  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.created,
    required this.updated,
  });


  // @override
  List<Object> get props => [id, title, content, created, updated];

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      created: DateTime.parse(json['created']).toLocal().toString(),
      updated: DateTime.parse(json['updated']).toLocal().toString(),
    );
  }
}

