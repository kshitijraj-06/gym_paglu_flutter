import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    final RxBool _obscurePassword = true.obs;
    final RxBool _obscureConfirmPassword = true.obs;
    final RxString _selectedGoal = 'Weight Loss'.obs;

  final List<String> _fitnessGoals = [
    'Weight Loss',
    'Muscle Gain',
    'Strength Training',
    'Endurance',
    'General Fitness'
  ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0F23),
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                // Title
                Text(
                  'CREATE ACCOUNT',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Join the AI Gym Trainer Community',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Signup Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Name Field
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.person, color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.grey[800],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Enter your name';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.email, color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.grey[800],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Enter email';
                          if (!value!.contains('@')) return 'Enter valid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Fitness Goal Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedGoal.value,
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: Colors.grey[800],
                        decoration: InputDecoration(
                          labelText: 'Fitness Goal',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.flag, color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.grey[800],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                          ),
                        ),
                        items: _fitnessGoals.map((goal) {
                          return DropdownMenuItem(
                            value: goal,
                            child: Text(goal),
                          );
                        }).toList(),
                        onChanged: (value) => _selectedGoal.value = value!,
                      ),
                      const SizedBox(height: 16),
                      // Password Field
                      Obx(() => TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword.value,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.lock, color: Colors.grey[400]),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword.value ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey[400],
                            ),
                            onPressed: () => _obscurePassword.value = !_obscurePassword.value,
                          ),
                          filled: true,
                          fillColor: Colors.grey[800],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Enter password';
                          if (value!.length < 6) return 'Password too short';
                          return null;
                        },
                      )),
                      const SizedBox(height: 16),
                      // Confirm Password Field
                      Obx(() => TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword.value,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword.value ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey[400],
                            ),
                            onPressed: () => _obscureConfirmPassword.value = !_obscureConfirmPassword.value,
                          ),
                          filled: true,
                          fillColor: Colors.grey[800],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Confirm password';
                          if (value != _passwordController.text) return 'Passwords do not match';
                          return null;
                        },
                      )),
                      const SizedBox(height: 24),
                      // Signup Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: Obx(() => ElevatedButton(
                          onPressed: authController.isLoading.value ? null : () => _handleSignup(authController, _formKey, _nameController, _emailController, _passwordController, _selectedGoal),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C63FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: authController.isLoading.value
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'CREATE ACCOUNT',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.inter(color: Colors.grey[400]),
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF6C63FF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _handleSignup(AuthController authController, GlobalKey<FormState> formKey, TextEditingController nameController, TextEditingController emailController, TextEditingController passwordController, RxString selectedGoal) {
  if (formKey.currentState?.validate() ?? false) {
    authController.signup(nameController.text, emailController.text, passwordController.text, selectedGoal.value);
  }
}