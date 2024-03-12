import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/database.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  int? selectIndex;

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = value ?? false; // Use value directly
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

void editTask(int index) {
  setState(() {
    selectIndex = index; // Set selectedIndex for editing
    _controller.text = db.toDoList[index][0];
  });

  showDialog(
    context: context,
    builder: (context) {
      return DialogBox(
        controller: _controller,
        onSave: () {
          setState(() {
            db.toDoList[index][0] = _controller.text; // Update the task text
           _controller.clear();
          });
          Navigator.of(context).pop(); // Close the dialog box
          db.updateDataBase();
        },
        onCancel: () => Navigator.of(context).pop(),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('TO DO',style: TextStyle(fontWeight: FontWeight.bold),),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const SearchScreen()),
                // );
              },
              child: const Icon(Icons.search),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade100,
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          final currentDate = DateTime.now()
              .toString()
              .substring(0, 10)
              .split('-')
              .reversed
              .join('-');
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1], // Convert string to boolean
            onChanged: (value) => checkBoxChanged(
              value,
              index,
            ),
            deleteFunction: (context) => deleteTask(index),
            editFunction: () => editTask(index),
            taskDate: currentDate,
          );
        },
      ),
    );
  }
}
