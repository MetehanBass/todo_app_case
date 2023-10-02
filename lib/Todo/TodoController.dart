import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:todo_app_v1/Todo/TodoModels.dart';
import 'package:todo_app_v1/Types/TodoStatusType.dart';

class TodoController extends GetxController {
  List<TodoModel> allTodos = [
    TodoModel(
      id: "1",
      name: "Study for the history exam.",
      status: TodoStatusType.ON_PROCESS,
    ),
    TodoModel(
      id: "2",
      name: "Complete the math homework.",
      status: TodoStatusType.ON_PROCESS,
    ),
    TodoModel(
      id: "3",
      name: "Read chapters 5 and 6 for literature class.",
      status: TodoStatusType.COMPLETED,
    ),
    TodoModel(
      id: "4",
      name: "Attend the after-school club meeting.",
      status: TodoStatusType.UNSTARTED,
    ),
  ];

  void addTodo(TodoModel newTodo) {
    allTodos.add(newTodo);
    update();
  }

  void removeTodo(String id) {
    allTodos.removeWhere((element) => element.id == id);
    update();
  }

  void changeSelectedTodo(String id, String? newName, TodoStatusType? newTodoStatusType) {
    TodoModel selectedTodo = allTodos.firstWhere((element) => element.id == id);

    if (newName != null) {
      selectedTodo.name = newName;
    }
    if (newTodoStatusType != null) {
      selectedTodo.status = newTodoStatusType;
    }

    update();
  }

  Color getColorFromTodoStatus(TodoStatusType todoStatusType) {
    return todoStatusType == TodoStatusType.COMPLETED
        ? Colors.green.shade700
        : todoStatusType == TodoStatusType.ON_PROCESS
            ? Colors.yellow.shade700
            : Colors.red.shade700;
  }

  String getTextFromTodoStatus(TodoStatusType todoStatusType) {
    return todoStatusType == TodoStatusType.COMPLETED
        ? "Completed"
        : todoStatusType == TodoStatusType.ON_PROCESS
            ? "On Process"
            : "Unstarted";
  }
}
