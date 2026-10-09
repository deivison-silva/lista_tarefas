import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lista_tarefas/app/features/task/models/task_model.dart';

class TaskController extends ChangeNotifier {
  // construir nossa lista de tarefas
  var lstTasks = <TaskModel>[]; // não possui elementos

  var isLoading = false;
  var isSuccess = false;
  var errorMessage = '';

  //TODO: Transformar addTask em Future<void> e adicionar delay (simulação de API) como nas demais funções
  //adicionar tarefa
  Future<void> addTask(TaskModel task) async {
    isSuccess = false;
    errorMessage = '';

    //carregando
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
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

  //Future: Indica que é uma operaão futura
  Future<void> removeTask(int index) async {
    // estado
    isSuccess = false;
    errorMessage = '';

    //carregando
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    // tentativa de remoão de uma tarefa - contempla o Delete
    try {
      lstTasks.removeAt(index);

      isLoading = false;
      isSuccess = true;
      notifyListeners();
    } catch (e, s) {
      log(
        'Erro ao remover tarefa',
        error: e,
        stackTrace: s,
        name: 'TaskController',
      );
      errorMessage = "Erro ao remover tarefa. Por favor, tente novamente.";
      isLoading = false;
      notifyListeners();
    }
  }

  //TODO: marcar como concluída
  Future<void> markAsDone(int index) async {
    // estado
    isSuccess = false;
    errorMessage = '';

    //carregando
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    lstTasks[index].isDone = true;

    isLoading = false;
    isSuccess = true;
    notifyListeners();
  }
}
