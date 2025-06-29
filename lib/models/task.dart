import 'package:uuid/uuid.dart';

enum TaskPriority { low, medium, high }
enum TaskStatus { open, completed }

class Task {
  final String id;
  String title;
  String description;
  DateTime dueDate;
  TaskStatus status;
  TaskPriority priority;

  Task({
    String? id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.status = TaskStatus.open,
    this.priority = TaskPriority.medium,
  }) : id = id ?? const Uuid().v4();

  bool get isComplete => status == TaskStatus.completed;

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    TaskStatus? status,
    TaskPriority? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'status': status.name,
      'priority': priority.name,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['dueDate']),
      status: TaskStatus.values.firstWhere((e) => e.name == json['status']),
      priority: TaskPriority.values.firstWhere((e) => e.name == json['priority']),
    );
  }
}