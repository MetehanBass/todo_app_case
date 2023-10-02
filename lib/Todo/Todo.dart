import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:todo_app_v1/Global/constant.dart';
import 'package:todo_app_v1/Todo/TodoController.dart';
import 'package:todo_app_v1/Todo/TodoModels.dart';
import 'package:todo_app_v1/Types/TodoStatusType.dart';
import 'package:uuid/uuid.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final controller = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
        body: GetBuilder<TodoController>(builder: (_) {
          return Container(
            width: size.width,
            height: size.height,
            color: kBackgroundColor,
            child: controller.allTodos.isEmpty
                ? Center(
                    child: Text(
                      'Todos not found',
                      style: k14w400AxiBlack(),
                    ),
                  )
                : SingleChildScrollView(
                    physics: kPhysic,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        SizedBox(height: padding.top),
                        for (var i = 0; i < controller.allTodos.length; i++)
                          Container(
                            width: size.width,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 3, offset: Offset.zero)],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: size.width,
                                  height: 30,
                                  color: controller.getColorFromTodoStatus(controller.allTodos[i].status),
                                  child: Center(
                                    child: Text(
                                      controller.getTextFromTodoStatus(controller.allTodos[i].status),
                                      style: k14w400AxiBlack(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 4,
                                        child: Container(
                                          child: Text(
                                            controller.allTodos[i].name,
                                            style: k14w400AxiBlack(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      TextEditingController textEditingController = TextEditingController(text: controller.allTodos[i].name);
                                                      Rx<TodoStatusType?> selectedTodoStatusType = controller.allTodos[i].status.obs;
                                                      return AlertDialog(
                                                        content: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            TextFormField(
                                                              maxLines: 2,
                                                              style: k14w400AxiBlack(),
                                                              controller: textEditingController,
                                                            ),
                                                            const SizedBox(height: 10),
                                                            StreamBuilder(
                                                                stream: selectedTodoStatusType.stream,
                                                                builder: (context, snapshot) {
                                                                  return DropdownButton<TodoStatusType>(
                                                                    isExpanded: true,
                                                                    iconSize: 35,
                                                                    iconDisabledColor: Colors.black,
                                                                    iconEnabledColor: Colors.black,
                                                                    style: k14w400AxiBlack(color: Colors.black),
                                                                    dropdownColor: Colors.white,
                                                                    icon: const Icon(
                                                                      Icons.arrow_drop_down_outlined,
                                                                    ),
                                                                    elevation: 0,
                                                                    items: [
                                                                      DropdownMenuItem<TodoStatusType>(
                                                                        value: TodoStatusType.UNSTARTED,
                                                                        child: Text(controller.getTextFromTodoStatus(TodoStatusType.UNSTARTED)),
                                                                      ),
                                                                      DropdownMenuItem<TodoStatusType>(
                                                                        value: TodoStatusType.ON_PROCESS,
                                                                        child: Text(controller.getTextFromTodoStatus(TodoStatusType.ON_PROCESS)),
                                                                      ),
                                                                      DropdownMenuItem<TodoStatusType>(
                                                                        value: TodoStatusType.COMPLETED,
                                                                        child: Text(controller.getTextFromTodoStatus(TodoStatusType.COMPLETED)),
                                                                      ),
                                                                    ],
                                                                    focusColor: Colors.black,
                                                                    onChanged: (newValue) {
                                                                      selectedTodoStatusType.value = newValue;
                                                                    },
                                                                    value: selectedTodoStatusType.value,
                                                                  );
                                                                })
                                                          ],
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            child: const Text(
                                                              "Update",
                                                              style: TextStyle(color: kPrimaryColor),
                                                            ),
                                                            onPressed: () {
                                                              controller.changeSelectedTodo(
                                                                controller.allTodos[i].id,
                                                                textEditingController.text != controller.allTodos[i].name ? textEditingController.text : null,
                                                                selectedTodoStatusType.value != controller.allTodos[i].status ? selectedTodoStatusType.value : null,
                                                              );
                                                              Navigator.pop(context);
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.edit,
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              InkWell(
                                                onTap: () {
                                                  controller.removeTodo(controller.allTodos[i].id);
                                                },
                                                child: const Icon(
                                                  Icons.remove_circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
          );
        }),
        floatingActionButton: InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                TextEditingController textEditingController = TextEditingController();
                Rx<TodoStatusType?> selectedTodoStatusType = TodoStatusType.UNSTARTED.obs;
                return AlertDialog(
                  title: Text(
                    'Add Todo',
                    style: k16w400MontBlack(
                      color: kPrimaryColor,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Note",
                            style: k12w400AxiBlack(color: kPrimaryColor.withOpacity(0.7)),
                          ),
                          TextFormField(
                            maxLines: 2,
                            style: k14w400AxiBlack(),
                            controller: textEditingController,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Status",
                            style: k12w400AxiBlack(color: kPrimaryColor.withOpacity(0.7)),
                          ),
                          StreamBuilder(
                              stream: selectedTodoStatusType.stream,
                              builder: (context, snapshot) {
                                return DropdownButton<TodoStatusType>(
                                  isExpanded: true,
                                  iconSize: 35,
                                  iconDisabledColor: Colors.black,
                                  iconEnabledColor: Colors.black,
                                  style: k14w400AxiBlack(color: Colors.black),
                                  dropdownColor: Colors.white,
                                  icon: const Icon(
                                    Icons.arrow_drop_down_outlined,
                                  ),
                                  elevation: 0,
                                  items: [
                                    DropdownMenuItem<TodoStatusType>(
                                      value: TodoStatusType.UNSTARTED,
                                      child: Text(controller.getTextFromTodoStatus(TodoStatusType.UNSTARTED)),
                                    ),
                                    DropdownMenuItem<TodoStatusType>(
                                      value: TodoStatusType.ON_PROCESS,
                                      child: Text(controller.getTextFromTodoStatus(TodoStatusType.ON_PROCESS)),
                                    ),
                                    DropdownMenuItem<TodoStatusType>(
                                      value: TodoStatusType.COMPLETED,
                                      child: Text(controller.getTextFromTodoStatus(TodoStatusType.COMPLETED)),
                                    ),
                                  ],
                                  focusColor: Colors.black,
                                  onChanged: (newValue) {
                                    selectedTodoStatusType.value = newValue;
                                  },
                                  value: selectedTodoStatusType.value,
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text(
                        "Add",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      onPressed: () {
                        controller.addTodo(
                          TodoModel(
                            id: const Uuid().v1(),
                            name: textEditingController.text,
                            status: selectedTodoStatusType.value!,
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ));
  }
}
