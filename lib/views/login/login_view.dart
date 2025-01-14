import 'package:dsw_51706/utils/my_colors.dart';
import 'package:dsw_51706/utils/my_images.dart';
import 'package:dsw_51706/views/register_view/register_view.dart';
import 'package:dsw_51706/views/home_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Walidacja e-maila
  String? _validateEmail(String? value) {
    const emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(emailPattern);
    if (value == null || value.isEmpty) {
      return 'Please enter your email.';
    } else if (!regex.hasMatch(value)) {
      return 'Not a valid email.';
    }
    return null;
  }

  // Walidacja hasła
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    return null;
  }

  // Zapis statusu logowania
  Future<void> _saveLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      _saveLoginStatus(); // Zapisz status logowania
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()), // Przejdź do HomeView
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                MyImages.logo,
                width: 129,
                height: 129,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 19.0),
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    height: 36.31 / 30,
                    color: Color(0xFF471AA0),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email or User Name',
                  prefixIcon: Icon(Icons.person_outline,
                      color: MyColors.purpleBoxpurplejasnyfiolet2),
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: MyColors.purpleBoxpurplejasnyfiolet2, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: MyColors.purpleBoxpurplejasnyfiolet2, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  ),
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline,
                      color: MyColors.purpleBoxpurplejasnyfiolet2),
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: MyColors.purpleBoxpurplejasnyfiolet2, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: MyColors.purpleBoxpurplejasnyfiolet2, width: 2.0),
                  ),
                ),
                validator: _validatePassword,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Akcja dla "Forget Password?"
                  },
                  child: Text(
                    'Forget Password ?',
                    style: TextStyle(color: MyColors.purpleBlackColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.boxthemecolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(390, 50),
                ),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Don’t have an account ? ',
                    style: TextStyle(
                      color: MyColors.purpleBlackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.9,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: MyColors.purpleBlackColor,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterView()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
