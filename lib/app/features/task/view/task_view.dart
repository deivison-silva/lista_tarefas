import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_tarefas/app/features/task/controllers/task_controller.dart';
import 'package:lista_tarefas/app/features/task/view/task_detail_view.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final controller = TaskController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Lista de Tarefas',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListenableBuilder(
          listenable: controller,
          builder: (_, _) => ListView.builder(
            itemCount: controller.lstTasks.length,
            itemBuilder: (context, index) {
              return Card(
                shadowColor: Colors.lightBlue,
                elevation: 4,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          controller.lstTasks[index].title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (context) => TaskDetailView(
                                    taskController: controller,
                                    index: index,
                                  ),
                                ),
                              )
                              .then((value) {
                                if (value == true) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Tarefa excluída com sucesso',
                                        ),
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 4),
                                      ),
                                    );
                                  }
                                }
                              });
                        },
                      ),
                    ],
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          'Descrição: ${controller.lstTasks[index].description}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Vencimento: ${DateFormat('dd/MM/yyyy').format(controller.lstTasks[index].dueDate)}',
                          overflow: TextOverflow.ellipsis, //dd/MM/yyyy
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          //fazer chamada da função de adicionar uma tarefa
        },
      ),
    );
  }
}
