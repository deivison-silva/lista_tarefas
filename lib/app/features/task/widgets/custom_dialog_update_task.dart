import 'package:flutter/material.dart';
import 'package:lista_tarefas/app/features/task/controllers/task_controller.dart';
import 'package:lista_tarefas/app/features/task/models/task_model.dart';
import 'package:lista_tarefas/app/features/task/widgets/custom_text_form_field.dart';

class CustomDialogUpdateTask extends StatefulWidget {
  final TaskController controller;
  final int index;
  const CustomDialogUpdateTask({
    super.key,
    required this.controller,
    required this.index,
  });

  @override
  State<CustomDialogUpdateTask> createState() => _CustomDialogUpdateTaskState();
}

class _CustomDialogUpdateTaskState extends State<CustomDialogUpdateTask> {
  //Atualizar tarefa
  final titleControllerUpdate = TextEditingController();
  final descriptionControllerUpdate = TextEditingController();
  final categoryControllerUpdate = TextEditingController();
  final dueDateControllerUpdate = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final titulo = widget.controller.lstTasks[widget.index].title;
    final descricao = widget.controller.lstTasks[widget.index].description;
    final categoria = widget.controller.lstTasks[widget.index].category;
    final dueDate = widget.controller.lstTasks[widget.index].dueDate;
    titleControllerUpdate.text = titulo;
    descriptionControllerUpdate.text = descricao;
    categoryControllerUpdate.text = categoria;
    dueDateControllerUpdate.text = dueDate.toString();
  }

  @override
  void dispose() {
    titleControllerUpdate.dispose();
    descriptionControllerUpdate.dispose();
    categoryControllerUpdate.dispose();
    dueDateControllerUpdate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Atualizar Tarefa'),
      content: SizedBox(
        height: 300,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: titleControllerUpdate,
                labelText: 'Título',
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: descriptionControllerUpdate,
                labelText: 'Descrição',
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: categoryControllerUpdate,
                labelText: 'Categoria',
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: dueDateControllerUpdate,
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
              await widget.controller.updateTask(
                widget.index,
                TaskModel(
                  id: 1,
                  title: titleControllerUpdate.text,
                  description: descriptionControllerUpdate.text,
                  category: categoryControllerUpdate.text,
                  dueDate: DateTime.parse(dueDateControllerUpdate.text),
                ),
              );
              if (context.mounted) {
                Navigator.of(context).pop();
              }

              if (widget.controller.isSuccess == true) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tarefa atualizada com sucesso'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 4),
                    ),
                  );
                }
              }

              titleControllerUpdate.clear();
              descriptionControllerUpdate.clear();
              categoryControllerUpdate.clear();
              dueDateControllerUpdate.clear();
            }
          },
          child: Text('Atualizar'),
        ),
      ],
    );
  }
}
