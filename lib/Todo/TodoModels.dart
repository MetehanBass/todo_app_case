import 'package:todo_app_v1/Types/TodoStatusType.dart';

class TodoModel {
  final String id;
  String name;
  TodoStatusType status;

  TodoModel({required this.id, required this.name, required this.status});
}
