import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dsw_51706/views/login/login_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Map<String, String>> tasks = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskData = prefs.getStringList('tasks') ?? [];
    setState(() {
      tasks = taskData
          .map((task) => Map<String, String>.from(Uri.splitQueryString(task)))
          .toList();
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskData = tasks.map((task) => Uri(queryParameters: task).query).toList();
    await prefs.setStringList('tasks', taskData);
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Usuń status logowania
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()), // Przejdź do ekranu logowania
    );
  }

  Future<void> _addOrEditTask({Map<String, String>? task}) async {
    _nameController.text = task?['name'] ?? '';
    _descriptionController.text = task?['description'] ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task == null ? 'Add Task' : 'Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Task Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Task Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final now = DateTime.now().toLocal().toString();
                final newTask = {
                  'name': _nameController.text,
                  'description': _descriptionController.text,
                  'date': now,
                };

                setState(() {
                  if (task == null) {
                    tasks.add(newTask);
                  } else {
                    tasks[tasks.indexOf(task)] = newTask;
                  }
                });

                _saveTasks();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTask(int index) async {
    setState(() {
      tasks.removeAt(index);
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, // Dodano funkcję wylogowania
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _addOrEditTask(),
          ),
        ],
      ),
      body: tasks.isEmpty
          ? const Center(
        child: Text('No tasks yet!', style: TextStyle(fontSize: 18)),
      )
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task['name'] ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task['description'] ?? ''),
                Text('Last modified: ${task['date'] ?? ''}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _addOrEditTask(task: task),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteTask(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
