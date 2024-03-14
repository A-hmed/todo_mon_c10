import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c10/model/todo.dart';
import 'package:todo_mon_c10/ui/provider/list_provider.dart';
import 'package:todo_mon_c10/ui/utils/app_theme.dart';

class AddBottomSheet extends StatefulWidget {

  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  late ListProvider listProvider;

  @override
  Widget  build(BuildContext context) {
    listProvider = Provider.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * .45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Add new task",
            textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle,
          ),
           TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: "Title"),
          ),
          const SizedBox(
            height: 12,
          ),
           TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: "Description"),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Select date",
            textAlign: TextAlign.start,
            style: AppTheme.bottomSheetTitleTextStyle
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: (){
              showMyDatePicker();
            },
            child: Text("${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}",
              textAlign: TextAlign.center,
              style: AppTheme.taskDescriptionTextStyle,),
          ),
          const Spacer(),
          ElevatedButton(onPressed: () {
            addTodoToFirestore();
          }, child: const Text("Add"))
        ],
      ),
    );
  }

  void addTodoToFirestore() async {
    CollectionReference todosCollection = FirebaseFirestore.instance.collection(Todo.collectionName);
    var doc = todosCollection.doc();
    doc.set({
      "id": doc.id,
      "title": titleController.text,
      "description": descriptionController.text,
      "date": selectedDate,
      "isDone": false,
    }).timeout(Duration(milliseconds: 300), onTimeout: (){
      listProvider.getTodosFromFireStore();
      Navigator.pop(context);
    });
  }

  void showMyDatePicker() async {
     selectedDate = await showDatePicker(context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365))) ?? selectedDate;
     setState(() {});
  }

}
