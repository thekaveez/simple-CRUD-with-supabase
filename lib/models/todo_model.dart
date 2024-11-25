
class ToDo{
  int? id;
  String title;

  ToDo({required this.title, this.id});

  factory ToDo.fromMap(Map<String, dynamic> map){
    return ToDo(
      id: map['id'],
      title: map['title'] as String,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'title': title,
    };
  }
}
