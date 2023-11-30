
import 'package:flutter/material.dart';

class TaskSkin extends StatefulWidget {
const TaskSkin({Key? key}) : super(key: key);

@override
_TaskSkinState createState() => _TaskSkinState();
}

class _TaskSkinState extends State<TaskSkin> {
List<Task> tasks = [];

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.lightBlueAccent,
floatingActionButton: FloatingActionButton(
backgroundColor: Colors.lightBlueAccent,
onPressed: () {
_showBottomDialog(context);
},
child: const Icon(
Icons.add,
color: Colors.white,
),
),
body: Column(
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
Container(
padding: const EdgeInsets.only(
top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
child: const Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
CircleAvatar(
radius: 30,
backgroundImage: AssetImage("assets/images/abid.jpeg"),
),
SizedBox(height: 10),
Text( "Md. Al Abid Supto",
style: TextStyle(
color: Colors.white,
fontSize: 17.0,
fontWeight: FontWeight.w700,
),
),
Text("abid123@gmail.com",
style: TextStyle(
color: Colors.white,
fontSize: 17.0,
),
),
SizedBox(height: 24),
Text(
"My Tasks",
style: TextStyle(
color: Colors.white,
fontSize: 32.0,
fontWeight: FontWeight.w700),
),
Text(
"3 Tasks",
style: TextStyle(
color: Colors.white,
fontSize: 18,
),
),
],
),
),
Expanded(
child: Container(
decoration: const BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.only(
topLeft: Radius.circular(20.0),
topRight: Radius.circular(20.0),
),
),
child: ListView.builder(
itemCount: tasks.length,
itemBuilder: (BuildContext context, int index) {
return TaskListItem(
task: tasks[index],
onCheckboxChanged: (value) {
setState(() {
tasks[index] = tasks[index].copyWith(isCompleted: value);
});
},
);
},
),
),
),
],
),
);
}

void _showBottomDialog(BuildContext context) {
showModalBottomSheet(
context: context,
builder: (BuildContext builderContext) {
return AddTaskWidget(
onTaskAdded: (String taskName) {
setState(() {
tasks.add(Task(name: taskName, isCompleted: false));
});
},
);
},
);
}
}

class TaskListItem extends StatelessWidget {
final Task task;
final ValueChanged<bool?> onCheckboxChanged;

const TaskListItem({
required this.task,
required this.onCheckboxChanged,
Key? key,
}) : super(key: key);

@override
Widget build(BuildContext context) {
return ListTile(
title: Text(
task.name,
style: TextStyle(
decoration: task.isCompleted == true
? TextDecoration.lineThrough
    : TextDecoration.none,
),
),
trailing: Checkbox(
value: task.isCompleted,
onChanged: onCheckboxChanged,
),
);
}
}

class AddTaskWidget extends StatefulWidget {
final ValueChanged<String> onTaskAdded;

const AddTaskWidget({required this.onTaskAdded, Key? key}) : super(key: key);

@override
_AddTaskWidgetState createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
final TextEditingController _taskController = TextEditingController();

@override
Widget build(BuildContext context) {
return Container(
padding: EdgeInsets.all(20.0),
child: Column(
mainAxisSize: MainAxisSize.min,
children: <Widget>[
Text(
'Add Task',
style: TextStyle(
fontSize: 20.0,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 10.0),
Divider(
color: Colors.black,
height: 20,
thickness: 2,
),
SizedBox(height: 10.0),
TextField(
controller: _taskController,
decoration: InputDecoration(
hintText: 'Enter your task...',
),
),
SizedBox(height: 10.0),
Container(
width: double.infinity,
child: TextButton(
onPressed: () {
if (_taskController.text.isNotEmpty) {
widget.onTaskAdded(_taskController.text);
_taskController.clear();
Navigator.pop(context);
}
},
style: ButtonStyle(
backgroundColor:
MaterialStateProperty.all(Colors.lightBlueAccent),
foregroundColor: MaterialStateProperty.all(Colors.white),
padding: MaterialStateProperty.all(
EdgeInsets.symmetric(vertical: 15.0),
),
shape: MaterialStateProperty.all(
RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8.0),
),
),
),
child: Text('Add Task'),
),
),
],
),
);
}
}

class Task {
final String name;
final bool? isCompleted;

Task({required this.name, this.isCompleted});

Task copyWith({bool? isCompleted}) {
return Task(
name: name,
isCompleted: isCompleted ?? this.isCompleted,
);
}
}

void main() {
runApp(MaterialApp(
home: TaskSkin(),
));
}


