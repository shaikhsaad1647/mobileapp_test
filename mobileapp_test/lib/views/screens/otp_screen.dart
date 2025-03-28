import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:mobileapp_test/controllers/login_controller.dart';
import '../../helper/text_styles.dart';
import '../widgets/auth_screen_layout.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late LoginController controller;
  Color? _tempButtonColor;
  Timer? _colorTimer;

  @override
  void initState() {
    super.initState();
    controller = Get.find<LoginController>();
    controller.clearOtpValues();
    controller.startTimer();
  }

  @override
  void dispose() {
    _colorTimer?.cancel();
    super.dispose();
  }

  void _changeButtonColorTemporarily() {
    setState(() {
      _tempButtonColor = Colors.green;
    });
    _colorTimer?.cancel();
    _colorTimer = Timer(const Duration(seconds: 1), () {
      setState(() {
        _tempButtonColor = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AuthScreenLayout(
      headerTitle: 'Just one more step',
      headerSubtitle: 'We\'ve sent a code to your email\n${controller.dummyUsers[controller.employeeId.value]?['email']}',
      children: [
        Text(
          'Please check your inbox and insert the code',
          style: AppTextStyles.regular(16, Colors.black),
        ),
        Obx(() => OtpTextField(
          numberOfFields: 6,
          borderColor: controller.isOtpInvalid.value ? const Color(0xFFF7C3C0) : Colors.grey,
          enabledBorderColor: controller.isOtpInvalid.value ? const Color(0xFFF7C3C0) : Colors.grey,
          focusedBorderColor: controller.isOtpInvalid.value ? const Color(0xFFF7C3C0) : const Color(0xFF1F4F74),
          borderWidth: 1.0,
          showFieldAsBox: true,
          borderRadius: BorderRadius.circular(8),
          fieldWidth: size.width * 0.1,
          fieldHeight: size.width * 0.125,
          textStyle: const TextStyle(fontSize: 15),
          onCodeChanged: (String code) {
            controller.isOtpInvalid.value = false;
            if (code.length == 6 && controller.otpCode.value.length != 6) {
              _changeButtonColorTemporarily();
            }
            controller.otpCode.value = code;
          },
          onSubmit: (String verificationCode) {
            controller.otpCode.value = verificationCode;
          },
        )),
        SizedBox(height: size.height * 0.005),
        Obx(() {
          if (controller.isOtpInvalid.value) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'Wrong OTP - ',
                  style: AppTextStyles.regular(14, Colors.red),
                ),
                TextButton(
                  onPressed: controller.timerSeconds.value == 0 ? controller.resendOtp : null,
                  child: Text(
                    'Send again',
                    style: AppTextStyles.regular(
                      14,
                      controller.timerSeconds.value == 0 ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ],
            );
          } else if (controller.timerSeconds.value == 0) {
            return Center(
              child: TextButton(
                onPressed: controller.resendOtp,
                child: Text(
                  'Send again',
                  style: AppTextStyles.regular(14, Colors.blue),
                ),
              ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Time left ',
                  style: AppTextStyles.regular(14, Colors.black),
                ),
                Text(
                  '00:${controller.timerSeconds.value.toString().padLeft(2, '0')}',
                  style: AppTextStyles.regular(14, Colors.red),
                ),
              ],
            );
          }
        }),
        SizedBox(height: size.height * 0.005),
        SizedBox(
          width: double.infinity,
          child: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
            onPressed: controller.verifyOtp,
            style: ElevatedButton.styleFrom(
              backgroundColor: _tempButtonColor ??
                  (controller.otpCode.value.length == 6
                      ? const Color(0xFF032540)
                      : const Color(0xFFD1D5E6)),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: AppTextStyles.bold(
                    16,
                    controller.otpCode.value.length == 6 ? Colors.white : Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.exit_to_app_outlined,
                  size: 20,
                  color: controller.otpCode.value.length == 6 ? Colors.white : Colors.grey,
                ),
              ],
            ),
          )),
        ),
      ],
    );
  }
}