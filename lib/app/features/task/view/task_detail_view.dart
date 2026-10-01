import 'package:flutter/material.dart';
import 'package:lista_tarefas/app/features/task/models/task_model.dart';

class TaskDetailView extends StatelessWidget {
  final TaskModel task;
  const TaskDetailView({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Detalhes da tarefa',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Título',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(task.title),
            Text(
              'Descrição',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(task.description),
            Text(
              'Categoria',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(task.category),
            Text(
              'Data de vencimento',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(task.dueDate.toString()),
          ],
        ),
      ),
    );
  }
}
