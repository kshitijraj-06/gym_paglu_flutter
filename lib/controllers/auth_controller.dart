import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    isLoggedIn.value = true;
    isLoading.value = false;
    
    Get.offAllNamed('/home');
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