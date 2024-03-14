import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_mon_c10/model/todo.dart';

class ListProvider extends ChangeNotifier {
  List<Todo> todos = [];
  DateTime selectedDate = DateTime.now();

  void getTodosFromFireStore() async {
    todos.clear();
    CollectionReference todosCollection =
    FirebaseFirestore.instance.collection(Todo.collectionName);
    QuerySnapshot querySnapshot = await todosCollection.get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    for(QueryDocumentSnapshot document in docs){
      Map map = document.data() as Map;
      Timestamp time = map["date"];
      Todo newTodo = Todo(id: map["id"],
          title: map["title"],
          description: map["description"],
          isDone: map["isDone"],
          date: time.toDate());
      if(selectedDate.year == newTodo.date.year &&
          selectedDate.month == newTodo.date.month &&
          selectedDate.day == newTodo.date.day){
        todos.add(newTodo);
      }
    }

    todos.sort((Todo todo1, Todo todo2){
      return todo1.date.compareTo(todo2.date);
    });
    notifyListeners();
  }
}