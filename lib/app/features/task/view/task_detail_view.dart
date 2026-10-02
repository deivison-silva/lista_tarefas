import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_tarefas/app/features/task/models/task_model.dart';

class TaskDetailView extends StatelessWidget {
  final TaskModel task;
  const TaskDetailView({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Detalhes da tarefa',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actionsPadding: const EdgeInsets.all(0),
        actions: [
          //botão de editar
          IconButton(
            padding: EdgeInsets.all(0),
            tooltip: 'Editar tarefa',
            onPressed: () {},
            icon: Icon(Icons.edit_rounded, color: Colors.orange),
          ),
          //botão de apagar
          IconButton(
            padding: EdgeInsets.all(0),
            tooltip: 'Excluir Tarefa',
            onPressed: () {},
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(DateFormat('dd/MM/yyyy').format(task.dueDate)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          'Concluir tarefa',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.green,
        icon: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
