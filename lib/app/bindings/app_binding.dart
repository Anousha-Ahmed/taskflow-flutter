import 'package:get/get.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/task_service.dart';
import '../../modules/home/controllers/home_controller.dart';
import '../../modules/tasks/controllers/task_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService(), permanent: true);
    Get.put(TaskService(), permanent: true);
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => TaskController());
  }
}