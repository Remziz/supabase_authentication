import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_authentication/pages/auth_pages/sign_in_screen.dart';
import 'package:supabase_authentication/pages/auth_pages/sign_up_screen.dart';
import 'package:supabase_authentication/pages/auth_pages/splash_screen.dart';
import 'package:supabase_authentication/pages/main_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash_screen',
      routes: {
        '/splash_screen': (context) {
          return const SplashScreen();
        },
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/register_page') {
          return CupertinoPageRoute(
            builder: (context) {
              return const SignUpScreen();
            },
            settings: settings,
          );
        }
        if (settings.name == '/main_page') {
          return CupertinoPageRoute(
            builder: (context) {
              return const HomePage();
            },
            settings: settings,
          );
        }
        if (settings.name == '/login_page') {
          return CupertinoPageRoute(
            builder: (context) {
              return const LogInScreen();
            },
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
