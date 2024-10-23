import 'package:chatify/pages/login_page.dart';
import 'package:chatify/providers/authentication_provider.dart';
import 'package:chatify/services/cloud_storage_service.dart';
import 'package:chatify/services/database_service.dart';
import 'package:chatify/services/media_service.dart';
import 'package:chatify/services/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _registerServices();
  runApp(const MyApp());
}

void _registerServices() {
  GetIt.instance.registerSingleton<NavigationService>(
    NavigationService(),
  );
  GetIt.instance.registerSingleton<MediaService>(
    MediaService(),
  );
  GetIt.instance.registerSingleton<DatabaseService>(
    DatabaseService(),
  );
  GetIt.instance.registerSingleton<CloudStorageService>(
    CloudStorageService(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (context) {
            return AuthenticationProvider();
          },
        )
      ],
      child: MaterialApp(
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
          }),
    );
  }
}
