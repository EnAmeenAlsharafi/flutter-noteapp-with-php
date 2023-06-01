class ModelNote {
  String? noteId;
  String? noteTitle;
  String? noteContent;
  String? noteImage;
  String? noteUser;

  ModelNote(
      {this.noteId,
      this.noteTitle,
      this.noteContent,
      this.noteImage,
      this.noteUser});

  ModelNote.fromJson(Map<String, dynamic> json) {
    noteId = json['noteId'];
    noteTitle = json['noteTitle'];
    noteContent = json['noteContent'];
    noteImage = json['noteImage'];
    noteUser = json['noteUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noteId'] = noteId;
    data['noteTitle'] = noteTitle;
    data['noteContent'] = noteContent;
    data['noteImage'] = noteImage;
    data['noteUser'] = noteUser;
    return data;
  }
}
