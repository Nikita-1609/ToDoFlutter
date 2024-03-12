import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final String ?taskDate;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function()? editFunction;


  // ignore: prefer_const_constructors_in_immutables
  ToDoTile({
    Key? key,
    required this.taskName,
    required this.taskCompleted,
    this.taskDate,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
  padding: const EdgeInsets.all(24),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: taskCompleted
          ? [Colors.grey, Colors.white]
          : [Colors.purple.shade200, Colors.white],
    ),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(width: 1),
  ),
  child: Row(
    children: [
      // Checkbox
      Checkbox(
        shape: const CircleBorder(),
        value: taskCompleted,
        onChanged: onChanged,
        activeColor: Colors.black,
      ),
      // Task name
      Expanded(
        child: Text(
          taskName,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: taskCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
      ),
      // Date
      const SizedBox(width: 10),
      // Edit icon button
      Column(
        children: [
          Visibility(
            visible: !taskCompleted,
            child: IconButton(
              onPressed: editFunction,
              icon:  Icon(Icons.edit)
            ),
          ),
          Text(
            '$taskDate',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ],
  ),
),

      ),
    );
  }
}
