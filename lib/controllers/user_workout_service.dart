import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_paglu/core/envVars.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/workout.dart';

class UserWorkoutService extends GetxController {
  final storage = FlutterSecureStorage();
  final RxList<Workout> selectedWorkouts = <Workout>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserWorkouts();
  }

  Future<void> fetchUserWorkouts() async {
    try {
      isLoading.value = true;
      final token = await storage.read(key: 'token');
      
      final response = await http.get(
        Uri.parse('http://68.233.96.179:8080/api/user-workouts'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        selectedWorkouts.value = data.map((json) => Workout.fromJson(json['workout'])).toList();
      }
    } catch (e) {
      print('Error fetching user workouts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addWorkout(Workout workout) async {
    try {
      final token = await storage.read(key: 'auth_token');
      
      final response = await http.post(
        Uri.parse('http://68.233.96.179:8080/api/user-workouts'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'workoutId': workout.id}),
      );

      if (response.statusCode == 200) {
        selectedWorkouts.add(workout);
      }
    } catch (e) {
      print('Error adding workout: $e');
    }
  }

  Future<void> removeWorkout(int workoutId) async {
    try {
      final token = await storage.read(key: 'auth_token');
      
      final response = await http.delete(
        Uri.parse('http://68.233.96.179:8080/api/user-workouts/$workoutId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        selectedWorkouts.removeWhere((w) => w.id == workoutId);
      }
    } catch (e) {
      print('Error removing workout: $e');
    }
  }
}