import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFucntion});

  String taskName;
  bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)?  deleteFucntion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
          SlidableAction(
            onPressed: deleteFucntion,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade300,
            borderRadius: BorderRadius.circular(13),),
        ],) ,
        child: Container(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orangeAccent)),
            child:  Row(
              children: [
                Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.orangeAccent,
                ),
                Text(taskName,style: TextStyle(decoration: taskCompleted? TextDecoration.lineThrough:TextDecoration.none),),
              ],
            )),
      ),
    );
  }
}
