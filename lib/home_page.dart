import 'package:flutter/material.dart';
import 'package:todo/database.dart';
import 'dialog_box.dart';
import 'todo_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box("mybox");
  ToDoDataBase db = ToDoDataBase();

  void initState(){
    // if this is the 1st time ever openin the app, then create default data
    if(_myBox.get("TODOLIST")==null){
      db.createInitialData();
    }else{
      //ther aleready exist data
      db.loadData();
    }
    
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();
  // list of todo task
  
  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (builder) {
        return DialogBox(
          controller: _controller,
          onSave:saveNewTask ,
          onCancel: ()=> Navigator.of(context).pop(),);
      },
    );
  }
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text("Todo"),
          elevation: 0,
        ),
        
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
       
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFucntion: (context) => deleteTask(index),
            );
          
          },
        ));
  }
}
