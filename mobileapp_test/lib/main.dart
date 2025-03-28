import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp_test/controllers/login_controller.dart';
import 'package:mobileapp_test/views/screens/login_screen.dart';

void main() {
  Get.put(LoginController()); // Initialize the controller
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}