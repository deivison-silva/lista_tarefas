import 'package:flutter/material.dart';
import 'package:lista_tarefas/app/features/task/controllers/task_controller.dart';
import 'package:lista_tarefas/app/features/task/models/task_model.dart';
import 'package:lista_tarefas/app/features/task/widgets/custom_text_form_field.dart';

class CustomDialogAddTask extends StatefulWidget {
  final TaskController controller;
  const CustomDialogAddTask({super.key, required this.controller});

  @override
  State<CustomDialogAddTask> createState() => _CustomDialogAddTaskState();
}

class _CustomDialogAddTaskState extends State<CustomDialogAddTask> {
  //Adicionar tarefa
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
    return AlertDialog(
      title: Text('Nova Tarefa'),
      content: SizedBox(
        height: 300,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: titleController,
                labelText: 'Título',
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: descriptionController,
                labelText: 'Descrição',
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: categoryController,
                labelText: 'Categoria',
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: dueDateController,
                labelText: 'Data de vencimento',
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
              await widget.controller.addTask(
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

              if (widget.controller.isSuccess == true) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tarefa adicionada com sucesso'),
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
  }
}
