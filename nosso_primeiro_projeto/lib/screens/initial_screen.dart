import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_inherited.dart';
import 'package:nosso_primeiro_projeto/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  double globalLevel = 0.00;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Tarefas'),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: LinearProgressIndicator(
                        value: globalLevel / 100,
                    ),
                  ),
                  Container(
                    width: 50,
                  ),
                  Text(
                    'Level: ${globalLevel}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              icon: Icon(Icons.loop),
              onPressed: () {
                setState(() {
                  globalLevel = TaskInherited.of(context).updateSumLevel();
                });
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        children: TaskInherited.of(context).taskList,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.black54,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(
                taskContext: context,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
