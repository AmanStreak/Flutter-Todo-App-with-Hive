import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model.dart';
import 'main.dart';
import 'package:hive/hive.dart';
class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {

  final todoBox = Hive.box('todo');


  addData(){
    Model myDataModel = Model(myTask, false);
    todoBox.add(myDataModel.toMap()).then((value) => print('Data submitted')).catchError((err) => print(err.toString()));
  }

  getData(){
    print(todoBox.length);
    for(int i = 0; i< todoBox.length; i++){
      print(todoBox.getAt(i)['task']);
    }

  }

  String myTask = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Task'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(

                child: WatchBoxBuilder(
                  box: todoBox,
                  builder: (context, todoBox){
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: todoBox.length,
                      itemBuilder: (context, i){
                        return GestureDetector(
                          onDoubleTap: (){
                            Model myMode = Model(todoBox.getAt(i)['task'], true);
                            todoBox.putAt(i, myMode.toMap());
                          },
                          child: ListTile(
                            leading: FlutterLogo(),
                            title: Text('Task: ${todoBox.getAt(i)['task']}'),
                            subtitle: todoBox.getAt(i)['taskStatus'] == true? Text('Status: Done') : Text('Status: Not Done.'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.check_circle, color: todoBox.getAt(i)['taskStatus'] == true? Colors.blue: Colors.grey,),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: (){
                                    todoBox.deleteAt(i);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter task",
                        ),
                        onChanged: (input){
                          myTask = input;

                        },
                      ),
                    ),
                    RaisedButton(
                      color: Colors.blue,
                        child: Text('ADD', style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),),
                        onPressed: (){
                          if(myTask.isNotEmpty){
                            addData();
                          }
                        }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
