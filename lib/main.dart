import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:todohive/todo.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final directoryDir = await path.getApplicationDocumentsDirectory();
  Hive.init(directoryDir.path);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose(){
    super.dispose();
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Hive.openBox('todo'),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return Text(snapshot.hasError.toString());
            }
            else{
              return Todo();
            }
          }
          else{
            return Scaffold();
          }
        },
      ),
    );
  }
}
