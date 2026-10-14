import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/constants/app_colors.dart';
import '../../../app/constants/app_icons.dart';
import '../../../app/constants/app_strings.dart';
import '../../../app/routes/app_routes.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Decorative orbs
          Positioned(
            top: -100.h,
            right: -80.w,
            child: _orb(240.r, AppColors.primary.withOpacity(0.12)),
          ),
          Positioned(
            top: 200.h,
            left: -120.w,
            child: _orb(200.r, AppColors.accent.withOpacity(0.10)),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),

                    // ── Logo ──────────────────────
                    Center(
                      child: Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          gradient: AppColors.coralGradient,
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 28.r,
                              offset: Offset(0, 12.h),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 42,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 36.h),

                    // ── Heading ────────────────────
                    Text(
                      'Welcome Back',
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
                      'Sign in to continue to your tasks',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 40.h),

                    // ── Email ──────────────────────
                    CustomTextField(
                      label: AppStrings.email,
                      hint: 'you@example.com',
                      prefixIcon: AppIcons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: controller.validateEmail,
                      onChanged: (v) => controller.emailController.value = v,
                    ),
                    SizedBox(height: 20.h),

                    // ── Password ───────────────────
                    Obx(() => CustomTextField(
                          label: AppStrings.password,
                          hint: 'Enter your password',
                          prefixIcon: AppIcons.password,
                          obscureText: controller.obscurePassword.value,
                          validator: controller.validatePassword,
                          textInputAction: TextInputAction.done,
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
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        )),
                    SizedBox(height: 36.h),

                    // ── Login Button ───────────────
                    Obx(() => CustomButton(
                          text: AppStrings.login,
                          isLoading: controller.isLoading.value,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.login();
                            }
                          },
                        )),
                    SizedBox(height: 36.h),

                    // ── Divider with OR ────────────
                    Row(
                      children: [
                        Expanded(
                          child: Container(height: 1, color: AppColors.border),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: AppColors.textHint,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(height: 1, color: AppColors.border),
                        ),
                      ],
                    ),
                    SizedBox(height: 28.h),

                    // ── Sign Up Link ───────────────
                    Center(
                      child: GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.signup),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: AppStrings.dontHaveAccount,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: AppStrings.signup,
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