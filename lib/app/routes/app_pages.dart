import 'package:get/get.dart';
import 'app_routes.dart';
import '../../modules/auth/views/login_view.dart';
import '../../modules/auth/views/signup_view.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/tasks/views/add_edit_task_view.dart';
import '../../modules/tasks/views/task_details_view.dart';
import '../../modules/auth/controllers/login_controller.dart';
import '../../modules/auth/controllers/signup_controller.dart';
import '../../modules/home/controllers/home_controller.dart';
import '../../modules/tasks/controllers/task_controller.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SignupController());
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomeController());
        Get.lazyPut(() => TaskController());
      }),
    ),
    GetPage(
      name: AppRoutes.addEditTask,
      page: () => const AddEditTaskView(),
    ),
    GetPage(
      name: AppRoutes.taskDetails,
      page: () => const TaskDetailsView(),
    ),
  ];
}