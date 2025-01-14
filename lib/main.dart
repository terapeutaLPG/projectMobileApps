import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dsw_51706/views/login/login_view.dart';
import 'package:dsw_51706/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MaterialApp(
    title: 'Task App',
    debugShowCheckedModeBanner: false,
    home: isLoggedIn ? HomeView() : LoginView(),
  ));
}
