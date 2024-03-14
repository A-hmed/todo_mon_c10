class Todo{
  static const String collectionName = 'todos';
  String id;
  String title;
  String description;
  bool isDone;
  DateTime date;

  Todo({required this.id,required  this.title, required this.description,
    required  this.isDone,required this.date});
}