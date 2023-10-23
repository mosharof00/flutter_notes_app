class Note {
  int? id;
  String? title;
  String? subtitle;
  dynamic date;
  //String? priority;

  Note({this.id, this.title, this.subtitle, this.date,
    //this.priority
  });

  Note.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    date = json['date'];
    //priority = json['priority'];
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'date': date,
      //'priority': priority,
    };
  }
}
