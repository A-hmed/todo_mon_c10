import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c10/model/todo.dart';
import 'package:todo_mon_c10/ui/provider/list_provider.dart';
import 'package:todo_mon_c10/ui/screens/home/tabs/list_tab/todo_widget.dart';

class ListTab extends StatefulWidget {

  ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider listProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listProvider.getTodosFromFireStore();
    });
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return Column(
      children: [
        EasyInfiniteDateTimeLine(
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          focusDate: listProvider.selectedDate,
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateChange: (selectedDate) {
            listProvider.selectedDate = selectedDate;
            listProvider.getTodosFromFireStore();
          },
        ),
        Expanded(
          child: ListView.builder(
              itemCount: listProvider.todos.length,
              itemBuilder: (context, index) => TodoWidget(todo: listProvider.todos[index],)),
        ),
      ],
    );
  }
}
