import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/constants/app_colors.dart';
import '../../../app/constants/app_icons.dart';
import '../../../app/constants/app_strings.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Decorative orbs
          Positioned(
            top: -100.h,
            left: -80.w,
            child: _orb(220.r, AppColors.accent.withOpacity(0.12)),
          ),
          Positioned(
            bottom: -80.h,
            right: -80.w,
            child: _orb(200.r, AppColors.primary.withOpacity(0.10)),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 16.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),

                    // ── Back Button ────────────────
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 46.w,
                        height: 46.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Center(
                          child: Icon(
                            AppIcons.back,
                            color: AppColors.textPrimary,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // ── Heading ────────────────────
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.8,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Start organizing your tasks today',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 36.h),

                    // ── Name ───────────────────────
                    CustomTextField(
                      label: AppStrings.fullName,
                      hint: 'John Doe',
                      prefixIcon: AppIcons.name,
                      controller: nameCtrl,
                      validator: controller.validateName,
                      onChanged: (v) => controller.nameController.value = v,
                    ),
                    SizedBox(height: 18.h),

                    // ── Email ──────────────────────
                    CustomTextField(
                      label: AppStrings.email,
                      hint: 'you@example.com',
                      prefixIcon: AppIcons.email,
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      validator: controller.validateEmail,
                      onChanged: (v) => controller.emailController.value = v,
                    ),
                    SizedBox(height: 18.h),

                    // ── Password ───────────────────
                    Obx(() => CustomTextField(
                          label: AppStrings.password,
                          hint: 'At least 6 characters',
                          prefixIcon: AppIcons.password,
                          controller: passCtrl,
                          obscureText: controller.obscurePassword.value,
                          validator: controller.validatePassword,
                          onChanged: (v) =>
                              controller.passwordController.value = v,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscurePassword.value
                                  ? AppIcons.visibilityOff
                                  : AppIcons.visibility,
                              color: AppColors.textHint,
                              size: 20.sp,
                            ),
                            onPressed: controller.togglePassword,
                          ),
                        )),
                    SizedBox(height: 18.h),

                    // ── Confirm Password ───────────
                    Obx(() => CustomTextField(
                          label: AppStrings.confirmPassword,
                          hint: 'Re-enter your password',
                          prefixIcon: AppIcons.password,
                          controller: confirmCtrl,
                          obscureText: controller.obscureConfirm.value,
                          validator: controller.validateConfirm,
                          textInputAction: TextInputAction.done,
                          onChanged: (v) =>
                              controller.confirmPasswordController.value = v,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscureConfirm.value
                                  ? AppIcons.visibilityOff
                                  : AppIcons.visibility,
                              color: AppColors.textHint,
                              size: 20.sp,
                            ),
                            onPressed: controller.toggleConfirm,
                          ),
                        )),
                    SizedBox(height: 36.h),

                    // ── Sign Up Button ─────────────
                    Obx(() => CustomButton(
                          text: AppStrings.signup,
                          isLoading: controller.isLoading.value,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.signUp();
                            }
                          },
                        )),
                    SizedBox(height: 28.h),

                    // ── Login Link ─────────────────
                    Center(
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: AppStrings.alreadyHaveAccount,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: AppStrings.login,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
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
}