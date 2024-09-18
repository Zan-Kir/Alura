import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/dash.png', 3),
    Task('Andar de Bike', 'assets/images/bike.jpeg', 2),
    Task('Meditar', 'assets/images/meditar.jpeg', 5),
    Task('Ler', 'assets/images/ler.jpg', 4),
    Task('Jogar', 'assets/images/jogar.jpg', 1),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length != taskList.length; //ele notifica sempre que o tamanho da lista é alterado old é o estado anterior do widget
  }
}
