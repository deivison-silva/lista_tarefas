import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lista_tarefas/app/features/task/models/task_model.dart';

class TaskController extends ChangeNotifier {
  // construir nossa lista de tarefas
  var lstTasks = <TaskModel>[
    TaskModel(
      id: 1,
      title: "Estudar Flutter",
      description:
          "Estudar Flutter descrição alkhsdkljahslkjdhalksjdhlakjsdklshdlkjashlkdjahskljdahlksjdhaklsjdhlkajsdhlkajshdklajshdlkjashldkjashlkdjashlkdjahslkdjahslkjdahlskjdahlksjdhaskljhk alkhsdkljahslkjdhalksjdhlakjsdklshdlkjashlkdjahskljdahlksjdhaklsjdhlkajsdhlkajshdklajshdlkjashldkjashlkdjashlkdjahslkdjahslkjdahlskjdahlksjdhaskljhk alkhsdkljahslkjdhalksjdhlakjsdklshdlkjashlkdjahskljdahlksjdhaklsjdhlkajsdhlkajshdklajshdlkjashldkjashlkdjashlkdjahslkdjahslkjdahlskjdahlksjdhaskljhk alkhsdkljahslkjdhalksjdhlakjsdklshdlkjashlkdjahskljdahlksjdhaklsjdhlkajsdhlkajshdklajshdlkjashldkjashlkdjashlkdjahslkdjahslkjdahlskjdahlksjdhaskljhk alkhsdkljahslkjdhalksjdhlakjsdklshdlkjashlkdjahskljdahlksjdhaklsjdhlkajsdhlkajshdklajshdlkjashldkjashlkdjashlkdjahslkdjahslkjdahlskjdahlksjdhaskljhkalkhsdkljahslkjdhalksjdhlakjsdklshdlkjashlkdjahskljdahlksjdhaklsjdhlkajsdhlkajshdklajshdlkjashldkjashlkdjashlkdjahslkdjahslkjdahlskjdahlksjdhaskljhk",
      category: "Estudo",
      dueDate: DateTime(2026, 10, 1),
    ),
    TaskModel(
      id: 2,
      title: "Estudar Dart",
      description:
          "Estudar Dart descrição alkhsdkljahslkjdhalksjdhlakjsdklshdlkjashlkdjahskljdahlksjdhaklsjdhlkajsdhlkajshdklajshdlkjashldkjashlkdjashlkdjahslkdjahslkjdahlskjdahlksjdhaskljhk",
      category: "Estudo",
      dueDate: DateTime(2026, 10, 2),
    ),
  ]; // não possui elementos

  var isLoading = false;
  var isSuccess = false;
  var errorMessage = '';

  //adicionar tarefa
  void addTask(TaskModel task) {
    isSuccess = false;
    errorMessage = '';

    //carregando
    isLoading = true;
    notifyListeners();

    //manipulação de dados
    //tentativa de inserção?
    try {
      lstTasks.add(
        TaskModel(
          id: task.id,
          title: task.title,
          description: task.description,
          category: task.category,
          dueDate: task.dueDate,
        ),
      );

      isLoading = false;
      isSuccess = true;
      notifyListeners();
    } catch (e, s) {
      log(
        'Erro ao adicionar tarefa',
        error: e,
        stackTrace: s,
        name: 'TaskController',
      );
      errorMessage = "Erro ao adicionar tarefa. Por favor, tente novamente.";
      isLoading = false;
      notifyListeners();
    }
  }

  //TODO: resetar o estado

  //TODO: remover tarefa

  //TODO: marcar como concluída
}
