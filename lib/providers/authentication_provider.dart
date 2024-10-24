import 'dart:developer';

import 'package:chatify/models/chat_user.dart';
import 'package:chatify/services/database_service.dart';
import 'package:chatify/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;
  late ChatUser userModel;
  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _databaseService.updateUserLastSeenType(user.uid);
        _databaseService.getUser(user.uid).then(
          (snapShop) {
            Map<String, dynamic> userData =
                snapShop.data()! as Map<String, dynamic>;
            userModel = ChatUser.fromJSON(
              {
                'uid': user.uid,
                'name': userData['name'],
                'email': userData['email'],
                'last_active': userData['last_active'],
                'image': userData['image']
              },
            );
            _navigationService.removeAndNavigateRoute('/home');
          },
        );
      } else {
        _navigationService.removeAndNavigateRoute('/login');
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
