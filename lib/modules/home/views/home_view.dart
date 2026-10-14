import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/constants/app_colors.dart';
import '../../../app/constants/app_icons.dart';
import '../../../app/constants/app_strings.dart';
import '../../../app/routes/app_routes.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/task_card.dart';
import '../controllers/home_controller.dart';
import '../../tasks/controllers/task_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskCtrl = Get.find<TaskController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Aurora Orbs
            Positioned(
              top: -60.h,
              right: -60.w,
              child: _orb(160.r, AppColors.primary.withOpacity(0.08)),
            ),
            Positioned(
              bottom: 200.h,
              left: -80.w,
              child: _orb(140.r, AppColors.accent.withOpacity(0.10)),
            ),

            Column(
              children: [
                // ═══════════════════════════════════════
                // HEADER
                // ═══════════════════════════════════════
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          gradient: AppColors.coralGradient,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 16.r,
                              offset: Offset(0, 6.h),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Obx(() => Text(
                              (controller.user.value?.name ?? 'U')
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            )),
                      ),
                      SizedBox(width: 14.w),

                      // Greeting
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hey there 👋',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Obx(() => Text(
                                  controller.user.value?.name ?? 'User',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                    letterSpacing: -0.5,
                                  ),
                                )),
                          ],
                        ),
                      ),

                      // Logout button
                      _circleBtn(AppIcons.logout, controller.logout),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // ═══════════════════════════════════════
                // HERO CARD (Progress %)
                // ═══════════════════════════════════════
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.r),
                    decoration: BoxDecoration(
                      gradient: AppColors.sunsetGradient,
                      borderRadius: BorderRadius.circular(28.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.35),
                          blurRadius: 30.r,
                          offset: Offset(0, 14.h),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6.r),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Your Progress',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),

                        
                        Obx(() {
                          final total = taskCtrl.totalTasksRx.value;
                          final done = taskCtrl.completedTasksRx.value;
                          final percent = total == 0
                              ? 0
                              : ((done / total) * 100).round();
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '$percent',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 52.sp,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -2.5,
                                  height: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 8.h, left: 4.w),
                                child: Text(
                                  '%',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: EdgeInsets.only(bottom: 6.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '$done of $total',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'tasks done',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                        SizedBox(height: 20.h),

                        // ✅ Progress bar — REACTIVE
                        Obx(() {
                          final total = taskCtrl.totalTasksRx.value;
                          final done = taskCtrl.completedTasksRx.value;
                          final progress = total == 0 ? 0.0 : done / total;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 10.h,
                              backgroundColor:
                                  Colors.white.withOpacity(0.25),
                              valueColor: const AlwaysStoppedAnimation(
                                Colors.white,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // ═══════════════════════════════════════
                // QUICK STATS — ✅ REACTIVE RxInt
                // ═══════════════════════════════════════
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: _quickStat(
                          'Total',
                          taskCtrl.totalTasksRx,
                          Icons.folder_rounded,
                          AppColors.accent2,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _quickStat(
                          'Done',
                          taskCtrl.completedTasksRx,
                          Icons.check_circle_rounded,
                          AppColors.success,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _quickStat(
                          'Active',
                          taskCtrl.pendingTasksRx,
                          Icons.pending_actions_rounded,
                          AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),

                // ═══════════════════════════════════════
                // SEARCH + SORT
                // ═══════════════════════════════════════
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10.r,
                                offset: Offset(0, 2.h),
                              ),
                            ],
                          ),
                          child: TextField(
                            onChanged: taskCtrl.search,
                            style: TextStyle(fontSize: 14.5.sp),
                            decoration: InputDecoration(
                              hintText: AppStrings.searchHint,
                              hintStyle: TextStyle(
                                color: AppColors.textHint,
                                fontSize: 14.sp,
                              ),
                              prefixIcon: Icon(
                                AppIcons.search,
                                color: AppColors.textHint,
                                size: 20.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 15.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      // Sort button
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10.r,
                              offset: Offset(0, 2.h),
                            ),
                          ],
                        ),
                        child: PopupMenuButton<String>(
                          icon: Icon(
                            AppIcons.sort,
                            color: AppColors.textSecondary,
                            size: 20.sp,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          onSelected: taskCtrl.setSort,
                          itemBuilder: (_) => const [
                            PopupMenuItem(
                              value: 'createdAt',
                              child: Text('Newest First'),
                            ),
                            PopupMenuItem(
                              value: 'priority',
                              child: Text('By Priority'),
                            ),
                            PopupMenuItem(
                              value: 'dueDate',
                              child: Text('By Due Date'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),

                // ═══════════════════════════════════════
                // FILTER CHIPS
                // ═══════════════════════════════════════
                Obx(() => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          _filterChip('All', taskCtrl),
                          SizedBox(width: 8.w),
                          _filterChip('Pending', taskCtrl),
                          SizedBox(width: 8.w),
                          _filterChip('Completed', taskCtrl),
                        ],
                      ),
                    )),
                SizedBox(height: 12.h),

                // ═══════════════════════════════════════
                // TASK LIST
                // ═══════════════════════════════════════
                Expanded(
                  child: Obx(() {
                    if (taskCtrl.isLoading.value) {
                      return const LoadingWidget(message: 'Loading...');
                    }
                    if (taskCtrl.filteredTasks.isEmpty) {
                      return _emptyState();
                    }
                    return ListView.builder(
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
                      itemCount: taskCtrl.filteredTasks.length,
                      itemBuilder: (_, i) {
                        final t = taskCtrl.filteredTasks[i];
                        return TaskCard(
                          task: t,
                          onTap: () => Get.toNamed(
                            AppRoutes.taskDetails,
                            arguments: t,
                          ),
                          onToggle: () => taskCtrl.toggleComplete(t),
                          onEdit: () => Get.toNamed(
                            AppRoutes.addEditTask,
                            arguments: t,
                          ),
                          onDelete: () => _confirmDelete(t.id, taskCtrl),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),

      // ═══ FAB — "New Task" ═══
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 8.h, right: 4.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 22.r,
                offset: Offset(0, 10.h),
              ),
            ],
          ),
          child: FloatingActionButton.extended(
            onPressed: () => Get.toNamed(AppRoutes.addEditTask),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.r),
            ),
            icon: Icon(Icons.add_rounded, size: 22.sp),
            label: Text(
              'New Task',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.5.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: AppColors.textPrimary,
            size: 20.sp,
          ),
        ),
      ),
    );
  }

  
  Widget _quickStat(String label, RxInt value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34.w,
            height: 34.h,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Icon(icon, color: color, size: 18.sp),
            ),
          ),
          SizedBox(height: 10.h),

          
          Obx(() => Text(
                value.value.toString(),
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              )),

          SizedBox(height: 1.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, TaskController taskCtrl) {
    final isSelected = taskCtrl.filter.value == label;
    return GestureDetector(
      onTap: () => taskCtrl.setFilter(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.coralGradient : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 14.r,
                    offset: Offset(0, 6.h),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w700,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 140.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                gradient: AppColors.peachGradient,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.inbox_rounded,
                  size: 46.sp,
                  color: AppColors.primary.withOpacity(0.6),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'No tasks yet',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Tap + to create your first task',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orb(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(color: color, blurRadius: 80.r, spreadRadius: 20.r),
        ],
      ),
    );
  }

  void _confirmDelete(String id, TaskController taskCtrl) {
    Get.defaultDialog(
      title: 'Delete Task',
      titleStyle: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 17.sp,
      ),
      middleText: AppStrings.deleteConfirm,
      middleTextStyle: TextStyle(
        fontSize: 14.sp,
        color: AppColors.textSecondary,
      ),
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      cancelTextColor: AppColors.textPrimary,
      buttonColor: AppColors.error,
      radius: 20.r,
      contentPadding: EdgeInsets.all(24.r),
      onConfirm: () {
        Get.back();
        taskCtrl.deleteTask(id);
      },
    );
  }
}