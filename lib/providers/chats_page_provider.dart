import 'dart:async';
import 'package:chatify/models/chat.dart';
import 'package:chatify/providers/authentication_provider.dart';
import 'package:chatify/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChatsPageProvider extends ChangeNotifier {
  late DatabaseService db;
  late StreamSubscription chatStream;
  AuthenticationProvider auth;
  List<Chat>? chats;

  ChatsPageProvider({required this.auth}) {
    db = GetIt.instance.get<DatabaseService>();
    getChats();
  }

  void getChats() async {}

  @override
  void dispose() {
    chatStream.cancel();
    super.dispose();
  }
}
