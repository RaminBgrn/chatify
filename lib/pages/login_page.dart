import 'package:chatify/widgets/custom_input_fields.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHight;
  late double _deviceWidth;

  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _deviceHight = MediaQuery.sizeOf(context).height;
    _deviceWidth = MediaQuery.sizeOf(context).width;
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
              loginForm(),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomInputFields(
                onSaved: (str) {},
                regEx: r"^[a-zA-Z0-9.a-z-A-Z0-9.!#$%&'*+-/=?^_`{|}]",
                hintText: "Email",
                obscure: false),
            CustomInputFields(
                onSaved: (str) {},
                regEx: r".{8,}",
                hintText: "Password",
                obscure: true)
          ],
        ),
      ),
    );
  }
}
