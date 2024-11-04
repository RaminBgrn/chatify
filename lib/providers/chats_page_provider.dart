import 'dart:async';
import 'dart:developer';
import 'package:chatify/models/chat.dart';
import 'package:chatify/models/chat_message.dart';
import 'package:chatify/models/chat_user.dart';
import 'package:chatify/providers/authentication_provider.dart';
import 'package:chatify/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  void getChats() async {
    try {
      chatStream =
          db.getChatsForUser(auth.userModel.uid).listen((snapshot) async {
        chats = await Future.wait(snapshot.docs.map((doc) async {
          Map<String, dynamic> chatData = doc.data() as Map<String, dynamic>;
          // get users in chat
          List<ChatUser> members = [];
          for (var uid in chatData['members']) {
            DocumentSnapshot userSnapShop = await db.getUser(uid);
            Map<String, dynamic> userDataMap =
                userSnapShop.data() as Map<String, dynamic>;
            members.add(ChatUser.fromJSON(userDataMap));
          }
          // get last message for chats
          List<ChatMessage> messages = [];
          QuerySnapshot chatMessage = await db.getLastMessageForChat(doc.id);
          if (chatMessage.docs.isNotEmpty) {
            Map<String, dynamic> messageData =
                chatMessage.docs.first.data()! as Map<String, dynamic>;
            ChatMessage message = ChatMessage.fromJson(messageData);
            messages.add(message);
          }
          // return chat instance
          return Chat(
            uid: doc.id,
            currentUserUid: auth.userModel.uid,
            members: members,
            messages: messages,
            activity: chatData['is_activity'],
            group: chatData['is_group'],
          );
        }).toList());
        notifyListeners();
      });
    } catch (e) {
      log('Error getting chats');
      log(e.toString());
    }
  }

  @override
  void dispose() {
    chatStream.cancel();
    super.dispose();
  }
}
