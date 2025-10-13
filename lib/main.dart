import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/home_screen.dart';
import 'controllers/auth_controller.dart';

void main() {
  runApp(const GymPagluApp());
}

class GymPagluApp extends StatelessWidget {
  const GymPagluApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AI Gym Trainer',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
      ],
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
      debugShowCheckedModeBanner: false,
    );
  }
}