import 'dart:developer';

import 'package:chatify/services/database_service.dart';
import 'package:chatify/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        log('Logged in');
      } else {
        log('Logged out');
      }
    });
  }

  Future<void> loginUsingEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      log(_auth.currentUser.toString());
    } on FirebaseAuthException {
      log('Error login in user into firebase');
    } catch (e) {
      log(e.toString());
    }
  }
}
