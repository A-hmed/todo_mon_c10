import 'package:flutter/material.dart';
import 'package:todo_mon_c10/model/todo.dart';
import 'package:todo_mon_c10/ui/utils/app_colors.dart';
import 'package:todo_mon_c10/ui/utils/app_theme.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  const TodoWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 22),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 4,
            decoration: BoxDecoration(
              color: AppColors.primiary,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  maxLines: 1,
                  style: AppTheme.taskTitleTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8,),
                Text(
                  todo.description,
                  style: AppTheme.taskDescriptionTextStyle,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primiary,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
            child: const Icon(
              Icons.check,
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}
