import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}

class Todo {
  String title;
  String description;
  DateTime date;
  DateTime registrationDate;
  String priority;

  Todo({required this.title, required this.description, required this.date, required this.registrationDate, required this.priority});
}

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  void addTodo(Todo task) {
    todos.add(task);
  }

  void editTodo(int index, Todo task) {
    todos[index] = task;
    update();
  }

  void removeTodo(int index) {
    todos.removeAt(index);
  }

  void reorderTodo(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final Todo item = todos.removeAt(oldIndex);
    todos.insert(newIndex, item);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Afazeres',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedPriority = 'Baixa';
  final ThemeController themeController = Get.put(ThemeController());

  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'Alta':
        return Colors.red.shade200;
      case 'Média':
        return Colors.yellow.shade200;
      default:
        return Colors.green.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: themeController.toggleTheme,
          ),
        ],
      ),
      body: Obx(() {
        if (todoController.todos.isEmpty) {
          return const Center(child: Text('Nenhuma tarefa adicionada.'));
        }
        return ReorderableListView(
          onReorder: todoController.reorderTodo,
          children: [
            for (int index = 0; index < todoController.todos.length; index++)
              Dismissible(
                key: ValueKey(todoController.todos[index]),
                background: Container(
                  color: Colors.blue,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    final taskController = TextEditingController(text: todoController.todos[index].title);
                    String editPriority = todoController.todos[index].priority;
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => StatefulBuilder(
                        builder: (context, setModalState) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: taskController,
                                  decoration: const InputDecoration(labelText: 'Editar Título'),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: ['Baixa', 'Média', 'Alta'].map((String value) {
                                    return Row(
                                      children: [
                                        Radio(
                                          value: value,
                                          groupValue: editPriority,
                                          onChanged: (String? newValue) {
                                            setModalState(() {
                                              editPriority = newValue!;
                                            });
                                          },
                                        ),
                                        Text(value),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    todoController.editTodo(
                                      index,
                                      Todo(
                                        title: taskController.text,
                                        description: '',
                                        date: DateTime.now(),
                                        registrationDate: DateTime.now(),
                                        priority: editPriority,
                                      ),
                                    );
                                    Get.back();
                                  },
                                  child: const Text('Salvar'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                    return false;
                  } else {
                    todoController.removeTodo(index);
                    return true;
                  }
                },
                child: ListTile(
                  title: Text(todoController.todos[index].title),
                  leading: CircleAvatar(
                    backgroundColor: getPriorityColor(todoController.todos[index].priority),
                  ),
                ),
              ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final taskController = TextEditingController();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => StatefulBuilder(
              builder: (context, setModalState) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: taskController,
                        decoration: const InputDecoration(labelText: 'Título da Tarefa'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: ['Baixa', 'Média', 'Alta'].map((String value) {
                          return Row(
                            children: [
                              Radio(
                                value: value,
                                groupValue: selectedPriority,
                                onChanged: (String? newValue) {
                                  setModalState(() {
                                    selectedPriority = newValue!;
                                  });
                                },
                              ),
                              Text(value),
                            ],
                          );
                        }).toList(),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          todoController.addTodo(Todo(
                            title: taskController.text,
                            description: '',
                            date: DateTime.now(),
                            registrationDate: DateTime.now(),
                            priority: selectedPriority,
                          ));
                          Get.back();
                        },
                        child: const Text('Adicionar'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
