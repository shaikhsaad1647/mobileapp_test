import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/screens/dashboard_screen.dart';
import '../views/screens/otp_screen.dart';

class LoginController extends GetxController {
  // Observables
  final employeeId = ''.obs;
  final otpCode = ''.obs;
  final generatedOtp = ''.obs;
  final isOtpSent = false.obs;
  final isLoading = false.obs;
  final timerSeconds = 60.obs;
  final isOtpInvalid = false.obs;
  final isEmployeeIdValid = true.obs;

  // Timer
  Timer? _timer;

  // RegExp for employee ID (e.g., ABDS-12345)
  final RegExp employeeIdPattern = RegExp(r'^[A-Z]{4}-\d{5}$');

  // Dummy users data
  final Map<String, Map<String, String>> dummyUsers = {
    'ABDS-12345': {
      'name': 'User One',
      'email': 'john.smith@albusayra.com',
      'company': 'Al-Hamama',
      'platform': 'BIKEYA - 12345',
    },
    'ABDS-67890': {
      'name': 'User Two',
      'email': 'jane.doe@albusayra.com',
      'company': 'Al-Hamama',
      'platform': 'BIKEYA - 67890',
    },
  };

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  bool isEmployeeIdFormatValid(String id) {
    return employeeIdPattern.hasMatch(id);
  }

  void startTimer() {
    timerSeconds.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void validateAndSendOtp() {
    isEmployeeIdValid.value = true;

    if (!isEmployeeIdFormatValid(employeeId.value) || !dummyUsers.containsKey(employeeId.value)) {
      isEmployeeIdValid.value = false;
      return;
    }

    isLoading.value = true;
    generatedOtp.value = _generateOtp();
    otpCode.value = '';
    Future.delayed(const Duration(seconds: 2), () {
      isOtpSent.value = true;
      isLoading.value = false;
      startTimer();
      Get.to(() => const OtpScreen());
    });
  }

  String _generateOtp() {
    final otp = (100000 + Random().nextInt(900000)).toString();
    Get.snackbar('OTP Sent', 'Your OTP is $otp', snackPosition: SnackPosition.TOP);
    return otp;
  }

  void resendOtp() {
    if (timerSeconds.value == 0) {
      generatedOtp.value = _generateOtp();
      startTimer();
      isOtpInvalid.value = false;
    }
  }

  void verifyOtp() {
    if (otpCode.value == generatedOtp.value) {
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false;
        Get.offAll(() => DashboardScreen(userName: dummyUsers[employeeId.value]!['name']!));
      });
    } else {
      timerSeconds.value = 0;
      isOtpInvalid.value = true;
    }
  }

  void clearOtpValues() {
    otpCode.value = '';
    isOtpInvalid.value = false;
    timerSeconds.value = 60;
    isOtpSent.value = false;
    _timer?.cancel();
  }

  void resetForm() {
    employeeId.value = '';
    otpCode.value = '';
    generatedOtp.value = '';
    isOtpSent.value = false;
    timerSeconds.value = 60;
    isOtpInvalid.value = false;
    _timer?.cancel();
  }
}