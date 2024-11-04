import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION = "Users";
const String CHAT_COLLECTION = "Chats";
const String MESSAGES_COLLECTION = "messages";

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUser(String uid) {
    return _db.collection(USER_COLLECTION).doc(uid).get();
  }

  Future<void> createUser(
      String uid, String email, String name, String imageUrl) async {
    try {
      await _db.collection(USER_COLLECTION).doc(uid).set({
        'name': name,
        'email': email,
        'image': imageUrl,
        'last_active': DateTime.now().toUtc(),
      });
    } catch (e) {
      log('Something went wrong $e');
    }
  }

  Future<QuerySnapshot> getLastMessageForChat(String chatId) {
    return _db
        .collection(CHAT_COLLECTION)
        .doc(chatId)
        .collection(MESSAGES_COLLECTION)
        .orderBy('sent_time', descending: true)
        .limit(1)
        .get();
  }

  Stream<QuerySnapshot> getChatsForUser(String uid) {
    return _db
        .collection(CHAT_COLLECTION)
        .where('members', arrayContains: uid)
        .snapshots();
  }

  Future<void> updateUserLastSeenType(String uid) async {
    try {
      await _db.collection(USER_COLLECTION).doc(uid).update({
        'last_active': DateTime.now().toUtc(),
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
