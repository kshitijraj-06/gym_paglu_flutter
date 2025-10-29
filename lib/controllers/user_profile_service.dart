import 'package:get/get.dart';
import 'chat_storage_service.dart';

class UserProfileService extends GetxController {
  var fitnessGoal = 'General Fitness'.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }
  
  Future<void> loadUserProfile() async {
    try {
      final profile = await ChatStorageService.loadChat('user_profile');
      if (profile.isNotEmpty) {
        fitnessGoal.value = profile.first['fitnessGoal'] ?? 'General Fitness';
      }
    } catch (e) {
      fitnessGoal.value = 'General Fitness';
    }
  }
  
  Future<void> updateFitnessGoal(String goal) async {
    fitnessGoal.value = goal;
    await ChatStorageService.saveChat('user_profile', [{'fitnessGoal': goal}]);
  }
}