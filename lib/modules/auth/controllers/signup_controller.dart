import 'package:flutter/material.dart';         
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/constants/app_strings.dart';
import '../../../app/constants/app_colors.dart';   
import '../../../data/services/auth_service.dart';

class SignupController extends GetxController {
  final _authService = Get.find<AuthService>();

  final nameController = ''.obs;
  final emailController = ''.obs;
  final passwordController = ''.obs;
  final confirmPasswordController = ''.obs;
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirm = true.obs;

  void togglePassword() => obscurePassword.toggle();
  void toggleConfirm() => obscureConfirm.toggle();

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.nameRequired;
    return null;
  }

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

  String? validateConfirm(String? value) {
    if (value != passwordController.value) return AppStrings.passwordMismatch;
    return null;
  }

  Future<void> signUp() async {
    try {
      isLoading.value = true;
      final user = await _authService.signUp(
        name: nameController.value,
        email: emailController.value,
        password: passwordController.value,
      );

      if (user != null) {
        Get.snackbar(
          'Account Created 🎉',
          'Welcome ${user.name}! Please login to continue.',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );

        // Clear form
        nameController.value = '';
        emailController.value = '';
        passwordController.value = '';
        confirmPasswordController.value = '';

        // Redirect to Login
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.error,   // ← constant se liya
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}