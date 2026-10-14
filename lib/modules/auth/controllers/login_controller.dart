import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/constants/app_strings.dart';
import '../../../data/services/auth_service.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();

  final emailController = ''.obs;
  final passwordController = ''.obs;
  final isLoading = false.obs;
  final obscurePassword = true.obs;

  void togglePasswordVisibility() => obscurePassword.toggle();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return AppStrings.emailRequired;
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return AppStrings.emailInvalid;
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.passwordRequired;
    if (value.length < 6) return AppStrings.passwordShort;
    return null;
  }

  Future<void> login() async {
    try {
      isLoading.value = true;
      final user = await _authService.login(
        email: emailController.value,
        password: passwordController.value,
      );
      if (user != null) {
        Get.snackbar('Success', 'Welcome back, ${user.name}!');
        Get.offAllNamed(AppRoutes.home, arguments: user);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }
}