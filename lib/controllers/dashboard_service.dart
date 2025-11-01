import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/envVars.dart';

class DashboardService extends GetxController {
  final storage = FlutterSecureStorage();
  final RxInt totalCalories = 0.obs;
  final RxInt workoutTime = 0.obs;
  final RxInt weeklyGoal = 0.obs;
  final RxInt streak = 0.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      final token = await storage.read(key: 'token');
      
      final response = await http.get(
        Uri.parse('${ApiConfig.serviceApi}/api/dashboard'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        totalCalories.value = data['totalCalories'] ?? 0;
        workoutTime.value = data['workoutTime'] ?? 0;
        weeklyGoal.value = data['weeklyGoal'] ?? 0;
        streak.value = data['streak'] ?? 0;
      }
    } catch (e) {
      print('Error fetching dashboard data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}