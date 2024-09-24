import 'package:nosso_primeiro_projeto/components/task.dart';
import 'package:nosso_primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  //attributes
  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';
  static const String _level = 'level';
  static const String _mastery = 'mastery';

  //constructor
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT, '
      '$_level TEXT, '
      '$_mastery TEXT)';

  //methods
  save(Task task) async {
    print('Iniciando o save: ');
    final Database db = await getDatabase();
    var itemExists = await findByName(task.name);
    if (itemExists.isEmpty) {
      print('A tarefa não existia');
      return await db.insert(_tableName, toMap(task));
    } else {
      print('A tarefa já existia');
      return await db.update(
        _tableName,
        toMap(task),
        where: '$_name = ?',
        whereArgs: [task.name],
      );
    }
  }

  Map<String, dynamic> toMap(Task task) {
    print('Convertendo tarefa em Map');
    final Map<String, dynamic> taskMap = Map();
    taskMap[_name] = task.name;
    taskMap[_difficulty] = task.difficulty;
    taskMap[_image] = task.image;
    taskMap[_level] = task.nivel;
    taskMap[_mastery] = task.masteryLvl;
    print('Mapa de tarefas: $taskMap');
    return taskMap;
  }

  Future<List<Task>> findAll() async {
    print('Acessando o findAll: ');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    print('Procurando dados no banco de dados... Encontrado: $result');
    List<Task> tasks = toList(result);
    for (Task task in tasks) {
      task.masteryColor = task.getMasteryColor(task.masteryLvl);
    }
    return tasks;
  }

  List<Task> toList(List<Map<String, dynamic>> taskList) {
    print('Convertendo to List: ');
    final List<Task> tasks = [];
    for (Map<String, dynamic> taskInList in taskList) {
      final Task task =
      Task(taskInList[_name], taskInList[_image], taskInList[_difficulty],
        nivel: int.parse(taskInList[_level]), masteryLvl: int.parse(taskInList[_mastery]));
      tasks.add(task);
    }
    print('Lista de Tarefas $tasks');
    return tasks;
  }

  Future<List<Task>> findByName(String taskName) async {
    print('Acessando find: ');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$_name = ?',
      whereArgs: [taskName],
    );
    print('Tarefa encontrada: ${toList(result)}');
    return toList(result);
  }

  delete(String taskName) async {
    print('Deletando tarefa: $taskName');
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: '$_name = ?',
      whereArgs: [taskName],
    );
  }
}
