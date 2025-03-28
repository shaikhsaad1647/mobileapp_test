import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp_test/controllers/login_controller.dart';
import '../../helper/text_styles.dart';
import '../widgets/auth_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _inputController;
  final LoginController controller = Get.find<LoginController>();

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AuthScreenLayout(
      headerTitle: 'Login your account',
      headerSubtitle: 'Please use your employee ID provided by your organisation to log in.',
      children: [
        RichText(
          text: TextSpan(
            text: 'Employee ID ',
            style: AppTextStyles.regular(16, Colors.black),
            children: [
              TextSpan(
                text: '*',
                style: AppTextStyles.regular(16, Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => TextField(
          controller: _inputController,
          onChanged: (value) {
            controller.employeeId.value = value;
            controller.isEmployeeIdValid.value = true;
          },
          decoration: InputDecoration(
            hintText: 'etc. ABDS-12345',
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: controller.isEmployeeIdValid.value ? Colors.grey : Colors.red,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: controller.isEmployeeIdValid.value ? Colors.grey : const Color(0xFFF7C3C0),
                width: 2.0,
              ),
            ),
          ),
        )),
        const SizedBox(height: 4),
        Obx(() => controller.isEmployeeIdValid.value
            ? const SizedBox.shrink()
            : Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              'Please type the correct id',
              style: AppTextStyles.regular(12, Colors.red),
            ),
          ],
        )),
        SizedBox(height: size.height * 0.03),
        SizedBox(
          width: double.infinity,
          child: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
            onPressed: () {
              controller.validateAndSendOtp();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.employeeIdPattern.hasMatch(controller.employeeId.value)
                  ? const Color(0xFF032540)
                  : Colors.grey[300],
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: AppTextStyles.bold(
                    16,
                    controller.employeeIdPattern.hasMatch(controller.employeeId.value)
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.exit_to_app_outlined,
                  size: 20,
                  color: controller.employeeIdPattern.hasMatch(controller.employeeId.value)
                      ? Colors.white
                      : Colors.grey,
                ),
              ],
            ),
          )),
        ),
      ],
    );
  }
}