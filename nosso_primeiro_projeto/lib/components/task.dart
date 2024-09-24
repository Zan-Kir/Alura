import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_dao.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String name;
  final String image;
  final int difficulty;
  int nivel;
  int masteryLvl;

  Task(this.name, this.image, this.difficulty, {this.nivel = 0, this.masteryLvl = 0, super.key});

  Color? masteryColor;

  Color? getMasteryColor(masteryLvl) {
    switch (masteryLvl) {
      case 0:
        return const Color(0xFF2F80ED);
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow[800];
      case 3:
        return Colors.orange[800];
      case 4:
        return Colors.red;
      case 5:
        return Colors.purpleAccent;
      case 6:
        return Colors.black;
    } return null;
  }

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.image.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: widget.masteryColor,
            ),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: (assetOrNetwork())
                            ? Image.asset(
                                widget.image,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget.image,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.name,
                              style: const TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis),
                            )),
                        Difficulty(difficultyLevel: widget.difficulty),
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Deseja excluir ${widget.name}?'),
                                  content:
                                      Text('A ação não pode ser desfeita.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Não'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        TaskDao().delete(widget.name);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Sim'),
                                    ),
                                  ],
                                  elevation: 24,
                                );
                              });
                        },
                        onPressed: () {
                          setState(() {
                            widget.nivel++;
                            if (widget.nivel / widget.difficulty == 10) {
                              widget.masteryLvl++;
                              if (widget.masteryLvl <= 6) {
                                widget.nivel = 0;
                              }
                              widget.masteryColor = widget.getMasteryColor(widget.masteryLvl);
                            }
                            TaskDao().save(widget);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_drop_up),
                            Text(
                              'UP',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.difficulty > 0)
                            ? ((widget.nivel / widget.difficulty) / 10)
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nível: ${widget.nivel}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
