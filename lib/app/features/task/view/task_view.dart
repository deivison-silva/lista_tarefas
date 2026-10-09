import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_tarefas/app/features/task/controllers/task_controller.dart';
import 'package:lista_tarefas/app/features/task/models/task_model.dart';
import 'package:lista_tarefas/app/features/task/view/task_detail_view.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final controller = TaskController();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final dueDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    dueDateController.dispose();
    super.dispose();
  }

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
                  return AlertDialog(
                    title: Text('Nova Tarefa'),
                    content: SizedBox(
                      height: 300,
                      child: Form(
                        key: formKey,
                        child: ListView(
                          children: [
                            TextFormField(
                              controller: titleController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Titulo é obrigatório';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: Text('Titulo'),
                              ),
                            ),
                            TextFormField(
                              controller: descriptionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Descrição é obrigatório';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: Text('Descrição'),
                              ),
                            ),
                            TextFormField(
                              controller: categoryController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Categoria é obrigatória';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: Text('Categoria'),
                              ),
                            ),
                            TextFormField(
                              controller: dueDateController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Data de vencimento é obrigatória';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: Text('Data de Vencimento'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await controller.addTask(
                              TaskModel(
                                id: 1,
                                title: titleController.text,
                                description: descriptionController.text,
                                category: categoryController.text,
                                dueDate: DateTime.parse(dueDateController.text),
                              ),
                            );
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }

                            if (controller.isSuccess == true) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Tarefa adicionada com sucesso',
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 4),
                                  ),
                                );
                              }
                            }

                            titleController.clear();
                            descriptionController.clear();
                            categoryController.clear();
                            dueDateController.clear();
                          }
                        },
                        child: Text('Salvar'),
                      ),
                    ],
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
