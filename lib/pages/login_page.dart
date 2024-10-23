import 'dart:developer';

import 'package:chatify/providers/authentication_provider.dart';
import 'package:chatify/services/navigation_service.dart';
import 'package:chatify/widgets/custom_input_fields.dart';
import 'package:chatify/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late NavigationService _navigationService;

  final _loginFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    _deviceHight = MediaQuery.sizeOf(context).height;
    _deviceWidth = MediaQuery.sizeOf(context).width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigationService = GetIt.instance.get<NavigationService>();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          // Focus.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.03,
            vertical: _deviceHight * 0.02,
          ),
          height: _deviceHight * 0.98,
          width: _deviceWidth * 0.97,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _pageTitle(),
              SizedBox(
                height: _deviceHight * 0.04,
              ),
              loginForm(),
              SizedBox(
                height: _deviceHight * 0.05,
              ),
              RoundedButton(
                  title: 'Login',
                  buttonHight: _deviceHight * 0.065,
                  buttonWidth: _deviceWidth * 0.65,
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()) {
                      _loginFormKey.currentState!.save();
                      log("Email: $_email , Password: $_password");
                      _auth.loginUsingEmailAndPassword(_email!, _password!);
                    }
                  }),
              SizedBox(
                height: _deviceHight * 0.002,
              ),
              registerAccountLink()
            ],
          ),
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return SizedBox(
      height: _deviceHight * 0.10,
      child: const Text(
        'Chatify',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget loginForm() {
    return SizedBox(
      height: _deviceHight * 0.18,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomInputFields(
                onSaved: (email) {
                  setState(() {
                    _email = email;
                  });
                },
                regEx: r"^[a-zA-Z0-9.a-z-A-Z0-9.!#$%&'*+-/=?^_`{|}]",
                hintText: "Email",
                obscure: false),
            const SizedBox(height: 10),
            CustomInputFields(
                onSaved: (password) {
                  setState(() {
                    _password = password;
                  });
                },
                regEx: r".{8,}",
                hintText: "Password",
                obscure: true)
          ],
        ),
      ),
    );
  }

  Widget registerAccountLink() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Don't have an account ?",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 14,
        ),
      ),
    );
  }
}
