import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_tarefas/app/features/task/controllers/task_controller.dart';

class TaskDetailView extends StatelessWidget {
  final TaskController taskController;
  final int index;
  const TaskDetailView({
    super.key,
    required this.taskController,
    required this.index,
  });

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
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return ListenableBuilder(
                    listenable: taskController,
                    builder: (context, _) {
                      if (taskController.isLoading == true) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return AlertDialog(
                        title: Text('Excluir Tarefa'),
                        content: Text(
                          'Tem certeza que deseja excluir esta tarefa?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await taskController.removeTask(index);
                              if (context.mounted) {
                                Navigator.pop(dialogContext);
                                Navigator.pop(context, true);
                              }
                            },
                            child: Text('Excluir'),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListenableBuilder(
          listenable: taskController,
          builder: (context, _) {
            if (taskController.isLoading == true) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            return SingleChildScrollView(
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Título',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(taskController.lstTasks[index].title),
                  Text(
                    'Descrição',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(taskController.lstTasks[index].description),
                  Text(
                    'Categoria',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(taskController.lstTasks[index].category),
                  Text(
                    'Data de vencimento',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat(
                      'dd/MM/yyyy',
                    ).format(taskController.lstTasks[index].dueDate),
                  ),
                  Text(
                    'Status: ${taskController.lstTasks[index].isDone ? "Concluída" : "Pendente"}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await taskController.markAsDone(index);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Tarefa concluída com sucesso'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
