// Import MaterialApp and other widgets which we can use to quickly create a material app
import 'package:flutter/material.dart';
// Code written in Dart starts exectuting from the main function. runApp is part of
// Flutter, and requires the component which will be our app's container. In Flutter,
// every component is known as a "widget".
void main() => runApp(new TodoApp());

// Every component in Flutter is a widget, even the whole app itself
class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Todo List',
        home: new TodoList()
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];


  void _addTodoItem(String task) {
    // Only add the task if the user actually entered something
    if(task.length > 0) {
      // Putting our code inside "setState" tells the app that our state has changed, and
      // it will automatically re-render the list
    setState(() => _todoItems.add(task));
     print(_todoItems);
    }
  }


  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
    print(_todoItems);
  }




  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${_todoItems[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    // The alert is actually part of the navigation stack, so to close it, we
                    // need to pop it.
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }








  // Build the whole list of todo items
  Widget _buildTodoList() {

    return new ListView.builder(

      itemBuilder: (context, index) {

        if(index < _todoItems.length) {

            return _buildTodoItem(_todoItems[index], index);

        }

      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {


      return new ListTile(
          title: new Text(todoText),

          onTap: () => _promptRemoveTodoItem(index)

      );


  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('Todo List')
      ),
      body:
          _buildTodoList(),

      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => helppage()));
          },
          child: Text('Help'),
          color: Colors.red,
          hoverColor: Colors.blue,
        )
      ],
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen,

          tooltip: 'Add task',
          child: new Icon(Icons.add)

      ),

    );
  }


  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well as adding
      // a back button to close it
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                      title: new Text('Add a new task')
                  ),
                  body: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                           width: 280,
                           padding: EdgeInsets.all(10.0),
                           child: TextField(
                           //autocorrect: true,
                           decoration: InputDecoration(hintText: 'Enter Task'),
                           onSubmitted: (val) {
                             _addTodoItem(val);
                           // Navigator.pop(context);
                           },
                           )
                           ),
                        FlatButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => helppage()));
                          },
                          child: Text('Help'),
                          color: Colors.red,
                          hoverColor: Colors.blue,
                        )

                        ],
                      ),
                   )
                  );
                  }
                  )
              );
            }


  }

class helppage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help page'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Welcome to your to-do list!\nNow you can keep a track of your tasks and complete them'),
            ),
            Expanded(
              child: Image.asset('images/img1.jpg'),
            ),

            ListTile(
              title: Text('Click on the + to add tasks'),
            ),
            Expanded(
              child: Image.asset('images/img2.jpg'),
            ),
            ListTile(
              title: Text('Enter new Task in the above space'),
            ),
            Expanded(
              child: Image.asset('images/img3.jpg'),
            ),
            ListTile(
              title: Text('Once new task is typed, go ahead and click on the tick box on your keyboard'),
            ),
            Expanded(
              child: Image.asset('images/img4.jpg'),
            ),
            ListTile(
              title: Text('If your done with the task, click on it and Mark it as done!'),
            ),
          ],

        ),
        ),
      );

  }
}




