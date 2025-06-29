import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';

class TaskService extends ChangeNotifier {
  final List<Task> _tasks = [];
  final _uuid = const Uuid();
  
  // Filter states
  TaskStatus? _statusFilter;
  TaskPriority? _priorityFilter;
  String _searchQuery = '';

  List<Task> get tasks => [..._tasks];
  
  List<Task> get filteredTasks {
    return _tasks.where((task) {
      // Status filter
      if (_statusFilter != null && task.status != _statusFilter) {
        return false;
      }
      
      // Priority filter
      if (_priorityFilter != null && task.priority != _priorityFilter) {
        return false;
      }
      
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        return task.title.toLowerCase().contains(query) ||
               task.description.toLowerCase().contains(query);
      }
      
      return true;
    }).toList();
  }

  List<Task> get openTasks => _tasks.where((task) => task.status == TaskStatus.open).toList();
  List<Task> get completedTasks => _tasks.where((task) => task.status == TaskStatus.completed).toList();

  void addTask(String title, String desc, DateTime dueDate, TaskPriority priority) {
    final newTask = Task(
      id: _uuid.v4(),
      title: title,
      description: desc,
      dueDate: dueDate,
      priority: priority,
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  void updateTask(Task updated) {
    final index = _tasks.indexWhere((t) => t.id == updated.id);
    if (index != -1) {
      _tasks[index] = updated;
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void toggleComplete(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      final currentTask = _tasks[index];
      _tasks[index] = currentTask.copyWith(
        status: currentTask.status == TaskStatus.open 
            ? TaskStatus.completed 
            : TaskStatus.open,
      );
      notifyListeners();
    }
  }

  // Filter methods
  void setStatusFilter(TaskStatus? status) {
    _statusFilter = status;
    notifyListeners();
  }

  void setPriorityFilter(TaskPriority? priority) {
    _priorityFilter = priority;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearFilters() {
    _statusFilter = null;
    _priorityFilter = null;
    _searchQuery = '';
    notifyListeners();
  }

  // Mock data for demo
  void loadMockData() {
    if (_tasks.isEmpty) {
      _tasks.addAll([
        Task(
          id: _uuid.v4(),
          title: 'Complete Hackathon Project',
          description: 'Finish the Todo app with all required features',
          dueDate: DateTime.now().add(const Duration(days: 2)),
          priority: TaskPriority.high,
        ),
        Task(
          id: _uuid.v4(),
          title: 'Review Code',
          description: 'Go through the implementation and test all features',
          dueDate: DateTime.now().add(const Duration(days: 1)),
          priority: TaskPriority.medium,
        ),
        Task(
          id: _uuid.v4(),
          title: 'Prepare Presentation',
          description: 'Create slides for the hackathon demo',
          dueDate: DateTime.now().add(const Duration(hours: 6)),
          priority: TaskPriority.low,
        ),
      ]);
      notifyListeners();
    }
  }
}
