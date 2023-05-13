class Note {
  final String title;
  final String desc;
  final DateTime createdAt;
  final int id;

  Note(this.title, this.desc, this.createdAt, this.id);

  Map<String, dynamic> toMap(){
    return {
      "title" : title,
      "desc" : desc,
      "createdAt": createdAt.toIso8601String(),
      "id" : id,
    };
  }

  factory Note.fromMap(Map<String, dynamic> data){
    return Note(data["title"], data["desc"], DateTime.parse(data["createdAt"]), data['id']);
  }
}