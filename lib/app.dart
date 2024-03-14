import 'package:flutter/material.dart';
import 'package:todo_mon_c10/ui/screens/auth/login/login.dart';
import 'package:todo_mon_c10/ui/screens/auth/register/register.dart';
import 'package:todo_mon_c10/ui/screens/home/home.dart';
import 'package:todo_mon_c10/ui/utils/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      routes: {
        Home.routeName: (_) => const Home(),
        Login.routeName: (_) => Login(),
        Register.routeName: (_) => Register(),
       },
      initialRoute: Login.routeName,
    );
  }
}