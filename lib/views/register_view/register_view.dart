import 'package:dsw_51706/utils/my_colors.dart';
import 'package:dsw_51706/utils/my_images.dart';
import 'package:dsw_51706/views/widgets/basic_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Obrazek Ellipse na górze po prawej
          Positioned(
            top: -25,
            right: -25,
            child: Image.asset(
              'assets/images/Ellipse.png', // Ścieżka bezpośrednia
              width: 213,
              height: 183,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF471AA0)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF471AA0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      height: 1.2,
                      color: Color(0xFF471AA0),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                BasicTextFormField(
                  initialValue: '',
                  hintText: 'Full Name',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 17),
                BasicTextFormField(
                  initialValue: '',
                  hintText: 'Email',
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 50),
                BasicTextFormField(
                  initialValue: '',
                  hintText: 'Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 50),
                BasicTextFormField(
                  initialValue: '',
                  hintText: 'Confirm Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.boxthemecolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(390, 50),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: MyColors.purpleBlackColor,
                        fontSize: 14,
                        height: 1.2,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            color: MyColors.purpleBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
