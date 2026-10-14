import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/auth_service.dart';
import '../../tasks/controllers/task_controller.dart';

class HomeController extends GetxController {
  final user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is UserModel) {
      user.value = args;
      Get.find<TaskController>().setUser(args);
    }
  }

  void logout() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Logout',
      textCancel: 'Cancel',
      confirmTextColor: Get.theme.colorScheme.onPrimary,
      buttonColor: Get.theme.colorScheme.primary,
      onConfirm: () {
        user.value = null;
        Get.offAllNamed(AppRoutes.login);
        Get.snackbar('Logged out', 'See you soon!');
      },
    );
  }
}