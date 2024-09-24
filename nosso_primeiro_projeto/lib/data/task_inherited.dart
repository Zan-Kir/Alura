import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/dash.png', 3, ),
    Task('Andar de Bike', 'assets/images/bike.jpeg', 2),
    Task('Meditar', 'assets/images/meditar.jpeg', 5),
    Task('Ler', 'assets/images/ler.jpg', 4),
    Task('Jogar', 'assets/images/jogar.jpg', 1),
  ];

  double levelGlobal = 0;
  int colorGlobal = 0;

  double updateSumLevel() {
    double total = 0;
    for (Task task in taskList) {
      switch (task.difficulty) {
        case 1:
          switch (task.masteryLvl) {
            case 0: total += task.nivel * 0.1;
            case 1: (task.nivel != 0) ? total += 1 + (task.nivel * 0.1) : total += 1; //10
            case 2: (task.nivel != 0) ? total += 2 + (task.nivel * 0.1) : total += 2; //20
            case 3: (task.nivel != 0) ? total += 3 + (task.nivel * 0.1) : total += 3; //30
            case 4: (task.nivel != 0) ? total += 4 + (task.nivel * 0.1) : total += 4; //40
            case 5: (task.nivel != 0) ? total += 5 + (task.nivel * 0.1) : total += 5; //50
            case 6: (task.nivel != 0) ? total += 6 + (task.nivel * 0.1) : total += 6; //60
            case 7: total += 7 + (task.nivel * 0.1 - 1);                              //70
          }
        case 2:
          switch (task.masteryLvl) {
            case 0: total += task.nivel * 0.2;
            case 1: (task.nivel != 0) ? total += 4 + (task.nivel * 0.2) : total += 4;   //20
            case 2: (task.nivel != 0) ? total += 8 + (task.nivel * 0.2) : total += 8;   //40
            case 3: (task.nivel != 0) ? total += 12 + (task.nivel * 0.2) : total += 12; //60
            case 4: (task.nivel != 0) ? total += 16 + (task.nivel * 0.2) : total += 16; //80
            case 5: (task.nivel != 0) ? total += 20 + (task.nivel * 0.2) : total += 20; //100
            case 6: (task.nivel != 0) ? total += 24 + (task.nivel * 0.2) : total += 24; //120
            case 7: total += 7 + (task.nivel * 0.2 + 17);                               //140
          }
        case 3:
          switch (task.masteryLvl) {
            case 0: total += task.nivel * 0.3;
            case 1: (task.nivel != 0) ? total += 9 + (task.nivel * 0.3) : total += 9;   //30
            case 2: (task.nivel != 0) ? total += 18 + (task.nivel * 0.3) : total += 18; //60
            case 3: (task.nivel != 0) ? total += 27 + (task.nivel * 0.3) : total += 27; //90
            case 4: (task.nivel != 0) ? total += 36 + (task.nivel * 0.3) : total += 36; //120
            case 5: (task.nivel != 0) ? total += 45 + (task.nivel * 0.3) : total += 45; //150
            case 6: (task.nivel != 0) ? total += 54 + (task.nivel * 0.3) : total += 54; //180
            case 7: total += 7 + (task.nivel * 0.3 + 47);                               //210
          }
        case 4:
          switch (task.masteryLvl) {
            case 0: total += task.nivel * 0.4;
            case 1: (task.nivel != 0) ? total += 16 + (task.nivel * 0.4) : total += 16; //40
            case 2: (task.nivel != 0) ? total += 32 + (task.nivel * 0.4) : total += 32; //80
            case 3: (task.nivel != 0) ? total += 48 + (task.nivel * 0.4) : total += 48; //120
            case 4: (task.nivel != 0) ? total += 64 + (task.nivel * 0.4) : total += 64; //160
            case 5: (task.nivel != 0) ? total += 80 + (task.nivel * 0.4) : total += 80; //200
            case 6: (task.nivel != 0) ? total += 96 + (task.nivel * 0.4) : total += 96; //240
            case 7: total += 7 + (task.nivel * 0.4 + 89);                               //280
          }
        case 5:
          switch (task.masteryLvl) {
            case 0: total += task.nivel * 0.5;
            case 1: (task.nivel != 0) ? total += 25 + (task.nivel * 0.5) : total += 25;   //50
            case 2: (task.nivel != 0) ? total += 50 + (task.nivel * 0.5) : total += 50;   //100
            case 3: (task.nivel != 0) ? total += 75 + (task.nivel * 0.5) : total += 75;   //150
            case 4: (task.nivel != 0) ? total += 100 + (task.nivel * 0.5) : total += 100;   //200
            case 5: (task.nivel != 0) ? total += 125 + (task.nivel * 0.5) : total += 125;   //250
            case 6: (task.nivel != 0) ? total += 150 + (task.nivel * 0.5) : total += 150;   //300
            case 7: total += 7 + (task.nivel * 0.5 + 143);                                 //350
          }
      }
    }
    return total;
  }

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length !=
        taskList
            .length; //ele notifica sempre que o tamanho da lista é alterado old é o estado anterior do widget
  }
}
