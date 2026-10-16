import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_tarefas/app/features/task/controllers/task_controller.dart';
import 'package:lista_tarefas/app/features/task/view/task_detail_view.dart';
import 'package:lista_tarefas/app/features/task/widgets/custom_dialog_add_task.dart';
import 'package:lista_tarefas/app/features/task/widgets/custom_dialog_update_task.dart';

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
          builder: (_, _) {
            if (controller.lstTasks.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhuma tarefa encontrada.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }

            return ListView.builder(
              itemCount: controller.lstTasks.length,
              itemBuilder: (context, index) {
                return Card(
                  color: controller.lstTasks[index].isDone == true
                      ? Colors.green.shade200
                      : Colors.blue.shade200,
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
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
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
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ListenableBuilder(
                              listenable: controller,
                              builder: (context, _) {
                                if (controller.isLoading == true) {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                }

                                return CustomDialogUpdateTask(
                                  controller: controller,
                                  context: context,
                                  index: index,
                                );
                              },
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit),
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
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return ListenableBuilder(
                listenable: controller,
                builder: (context, _) {
                  if (controller.isLoading == true) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return CustomDialogAddTask(
                    context: context, //passa contexto do showDialog linha 148
                    controller: controller,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
