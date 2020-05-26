class Model{
  String todoTask;
  bool taskStatus;

  Model(this.todoTask, this.taskStatus);

  Map<dynamic, dynamic> toMap(){
    Map<dynamic, dynamic> map = Map<dynamic, dynamic>();
    map['task'] = this.todoTask;
    map['taskStatus'] = this.taskStatus;
    return map;
  }

}