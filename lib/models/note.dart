class Note {
  final int nid;
  final String title;
  final String description;
  final String timestamp;
  final int priority;
  final int isDone;

  Note(
      {this.nid,
      this.title,
      this.description,
      this.timestamp,
      this.priority,
      this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'note_id': nid,
      'note_title': title,
      'note_desc': description,
      'note_created_at': timestamp,
      'note_priority': priority,
      'note_is_done': isDone,
    };
  }

  factory Note.fromMap(Map<String, dynamic> json) => new Note(
        nid: json['note_id'],
        title: json['note_title'],
        description: json['note_desc'],
        timestamp: json['note_created_at'],
        priority: json['note_priority'],
        isDone: json['note_is_done'],
      );
}
