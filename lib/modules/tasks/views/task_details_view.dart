import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../app/constants/app_colors.dart';
import '../../../app/constants/app_icons.dart';
import '../../../app/routes/app_routes.dart';
import '../../../data/models/task_model.dart';
import '../controllers/task_controller.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key});

  Color _priorityColor(TaskPriority p) {
    switch (p) {
      case TaskPriority.high:
        return AppColors.priorityHigh;
      case TaskPriority.medium:
        return AppColors.priorityMedium;
      case TaskPriority.low:
        return AppColors.priorityLow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = Get.arguments as TaskModel;
    final ctrl = Get.find<TaskController>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(AppIcons.back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.edit, color: AppColors.primary),
            onPressed: () =>
                Get.toNamed(AppRoutes.addEditTask, arguments: task),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: task.isCompleted
                    ? AppColors.success.withOpacity(0.12)
                    : AppColors.warning.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    task.isCompleted
                        ? AppIcons.checkCircle
                        : Icons.pending_outlined,
                    size: 16,
                    color: task.isCompleted
                        ? AppColors.success
                        : AppColors.warning,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    task.isCompleted ? 'Completed' : 'Pending',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: task.isCompleted
                          ? AppColors.success
                          : AppColors.warning,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text(
              task.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            const SizedBox(height: 24),

            // Info Cards
            _infoRow(AppIcons.calendar, 'Due Date',
                DateFormat('EEEE, MMM dd, yyyy').format(task.dueDate)),
            const SizedBox(height: 14),
            _infoRow(
              AppIcons.flag,
              'Priority',
              task.priority.name[0].toUpperCase() +
                  task.priority.name.substring(1),
              valueColor: _priorityColor(task.priority),
            ),
            const SizedBox(height: 14),
            _infoRow(Icons.access_time, 'Created',
                DateFormat('MMM dd, yyyy • HH:mm').format(task.createdAt)),
            const SizedBox(height: 28),

            if (task.description.isNotEmpty) ...[
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  task.description,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => ctrl.toggleComplete(task),
                    icon: Icon(
                      task.isCompleted
                          ? AppIcons.radioUnchecked
                          : AppIcons.checkCircle,
                      size: 18,
                    ),
                    label: Text(task.isCompleted
                        ? 'Mark Pending'
                        : 'Mark Complete'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: task.isCompleted
                          ? AppColors.warning
                          : AppColors.success,
                      side: BorderSide(
                        color: task.isCompleted
                            ? AppColors.warning
                            : AppColors.success,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Delete Task',
                        middleText:
                            'Are you sure you want to delete this task?',
                        textConfirm: 'Delete',
                        textCancel: 'Cancel',
                        confirmTextColor: Colors.white,
                        buttonColor: AppColors.error,
                        onConfirm: () {
                          Get.back(); // close dialog
                          ctrl.deleteTask(task.id);
                          Get.back(); // close details screen
                        },
                      );
                    },
                    icon: const Icon(AppIcons.delete, size: 18),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value,
      {Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: valueColor ?? AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}