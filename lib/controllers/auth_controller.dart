import 'dart:convert';

import 'package:get/get.dart';
import 'package:gym_paglu/core/envVars.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.serviceApi}/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        print('Login successful');
        isLoggedIn.value = true;
        Get.offAllNamed('/home');
      } else {
        print('Login failed: ${response.statusCode}');
        isLoggedIn.value = false;
      }
    } catch (e) {
      print('Error during login: $e');
      isLoggedIn.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(String name, String email, String password, String goal) async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    isLoggedIn.value = true;
    isLoading.value = false;
    
    Get.offAllNamed('/home');
  }
  
  void logout() {
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}