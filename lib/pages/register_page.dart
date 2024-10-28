import 'package:chatify/providers/authentication_provider.dart';
import 'package:chatify/services/cloud_storage_service.dart';
import 'package:chatify/services/database_service.dart';
import 'package:chatify/services/media_service.dart';
import 'package:chatify/services/navigation_service.dart';
import 'package:chatify/widgets/custom_input_fields.dart';
import 'package:chatify/widgets/rounded_button.dart';
import 'package:chatify/widgets/rounded_image_network.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  late double deviceHight;
  late double deviceWidth;

  late AuthenticationProvider _auth;
  late DatabaseService _db;
  late CloudStorageService _cloudStorageService;
  late NavigationService _navigationService;

  String? _name;
  String? _email;
  String? _password;
  final _registerFormKey = GlobalKey<FormState>();

  PlatformFile? _profileImageFile;

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _db = GetIt.instance.get<DatabaseService>();
    _navigationService = GetIt.instance.get<NavigationService>();
    _cloudStorageService = GetIt.instance.get<CloudStorageService>();
    deviceHight = MediaQuery.sizeOf(context).height;
    deviceWidth = MediaQuery.sizeOf(context).width;
    return _buildUi();
  }

  Widget _buildUi() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: deviceHight * 0.98,
        width: deviceWidth * 0.97,
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.03,
          vertical: deviceWidth * 0.02,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _profileImage(),
            const SizedBox(
              height: 28,
            ),
            _registerForm(),
            const SizedBox(
              height: 28,
            ),
            RoundedButton(
              title: 'Register',
              buttonHight: deviceHight * 0.065,
              buttonWidth: deviceWidth * 0.65,
              onPressed: () async {
                if (_registerFormKey.currentState!.validate() &&
                    _profileImageFile != null) {
                  _registerFormKey.currentState!.save();
                  String? uid = await _auth.registerUserUsingEmailAndPassword(
                      _email!, _password!);
                  String? imageUrl = await _cloudStorageService
                      .saveUserImageToStorage(uid!, _profileImageFile!);
                  await _db.createUser(uid, _email!, _name!, imageUrl!);
                  _navigationService.goBack();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileImage() {
    return GestureDetector(
      onTap: () async {
        GetIt.instance.get<MediaService>().pickImageFromLibrary().then((image) {
          setState(() {
            _profileImageFile = image;
          });
        });
      },
      child: () {
        if (_profileImageFile != null) {
          return RoundedImageLocal(
            image: _profileImageFile!,
            size: deviceHight * 0.15,
          );
        } else {
          return RoundedImageNetwork(
              key: UniqueKey(),
              imagePath:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBjknSFU0Y8zCyo-MNCROWd0CRhyrK4TIuY8evOwljxdA4ymnEVy0pEmdddozbuXUPc7Y&usqp=CAU",
              size: deviceHight * 0.15);
        }
      }(),
    );
  }

  Widget _registerForm() {
    return SizedBox(
      height: deviceHight * 0.35,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomInputFields(
                onSaved: (name) {
                  setState(() => _name = name);
                },
                regEx: r'.{8,}',
                hintText: "Name",
                obscure: false),
            CustomInputFields(
                onSaved: (email) {
                  setState(() => _email = email);
                },
                regEx:
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                hintText: "Email",
                obscure: false),
            CustomInputFields(
                onSaved: (password) {
                  setState(() => _password = password);
                },
                regEx: r'.{8,}',
                hintText: "Password",
                obscure: true),
          ],
        ),
      ),
    );
  }
}
