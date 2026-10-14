enum TaskPriority { low, medium, high }

class TaskModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskPriority priority;
  final bool isCompleted;
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
    required this.createdAt,
  });

  TaskModel copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
    TaskPriority? priority,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id,
      userId: userId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'priority': priority.index,
        'isCompleted': isCompleted ? 1 : 0,
        'createdAt': createdAt.toIso8601String(),
      };

  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
        id: map['id'] as String,
        userId: map['userId'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        dueDate: DateTime.parse(map['dueDate'] as String),
        priority: TaskPriority.values[map['priority'] as int],
        isCompleted: (map['isCompleted'] as int) == 1,
        createdAt: DateTime.parse(map['createdAt'] as String),
      );
}