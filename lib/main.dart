import 'package:chatify/pages/home_page.dart';
import 'package:chatify/pages/login_page.dart';
import 'package:chatify/pages/splash_page.dart';
import 'package:chatify/services/navigation_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chatify',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(36, 35, 49, 1.0)),
          scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
          useMaterial3: true,
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: "/login",
        routes: {
          '/login': (BuildContext context) => const LoginPage(),
        });
  }
}
