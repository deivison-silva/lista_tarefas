// CLASSE / ABSTRAÇÃO: O modelo (planta baixa) que abstrai os dados de uma tarefa
class TaskModel {
  // ATRIBUTOS / PROPRIEDADES: As características ou dados que o objeto guarda
  int id;
  String title;
  String description;
  bool isDone;
  String category;
  DateTime dueDate;

  // CONSTRUTOR: Método especial executado ao instanciar o objeto para inicializar os atributos
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
    required this.category,
    required this.dueDate,
  });
}
